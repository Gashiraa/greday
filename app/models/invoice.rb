# frozen_string_literal: true

class Invoice < ApplicationRecord
  include TranslateEnum

  belongs_to :payment, optional: true
  belongs_to :customer, optional: true

  has_many :projects, dependent: :nullify
  has_many :expense_accounts, dependent: :nullify
  has_one :partial_invoice, dependent: :nullify

  enum status: [:created, :paid, :mailed, :emailed]
  translate_enum :status

  def update_invoice_content_on_destroy(invoice, company)

    if company == "PLUSVIEW"
      invoice.projects.update(status: :accepted, invoice_id: nil)
    else
      invoice.projects.update(status: :done, invoice_id: nil)
    end

    invoice.projects.each do |project|
      project.wares.update(status: :assigned_project)
      project.services.update(status: :assigned)
    end
  end

  def get_tva_rates(invoice)
    Service.joins(project: :invoice).select(:tva_rate).where("invoices.id = " + invoice.id.to_s)
           .union(ProjectExtraLine.joins(project: :invoice).select(:tva_rate).where("invoices.id = " + invoice.id.to_s))
           .union(Ware.joins(project: :invoice).select(:tva_rate).where("invoices.id = " + invoice.id.to_s))
           .union(PartialInvoice.select(:pct).where("invoice_id = " + invoice.id.to_s))
           .pluck(:tva_rate)
  end

  def get_tva_amounts(tva_rate, invoice)
    tva = []
    amount = 0
    base = 0
    invoice.projects.each do |project|
      amount += project.services.where(tva_rate: tva_rate).collect { |s| s.valid? ? s.total_cost - s.total_gross : 0 }.sum
      base += project.services.where(tva_rate: tva_rate).collect { |s| s.valid? ? s.total_gross : 0 }.sum
      amount += project.wares.where(tva_rate: tva_rate).collect { |w| w.valid? ? w.total_cost - w.total_gross : 0 }.sum
      base += project.wares.where(tva_rate: tva_rate).collect { |w| w.valid? ? w.total_gross : 0 }.sum
      amount += project.project_extra_lines.where(tva_rate: tva_rate).collect { |pel| pel.valid? ? pel.total - pel.total_gross : 0 }.sum
      base += project.project_extra_lines.where(tva_rate: tva_rate).collect { |pel| pel.valid? ? pel.total_gross : 0 }.sum
      next unless project.partial_invoice

      if project.partial_invoice.pct == tva_rate
        base -= project.partial_invoice.amount
        amount -= (project.partial_invoice.amount / 100 * project.partial_invoice.pct)
      end
    end
    if invoice.partial_invoice
      base += invoice.partial_invoice.amount
      amount += (invoice.partial_invoice.amount / 100 * invoice.partial_invoice.pct)
    end

    tva.push(amount)
    tva.push(base)
  end

  def update_totals_invoice(invoice, projects)
    invoice.update(total: do_total(invoice, projects),
                   total_gross: do_total_gross(invoice, projects))
  end

  def do_total(invoice, projects)
    total = projects.collect { |p| p.valid? ? p.total : 0 }.sum
    total += invoice.partial_invoice.amount * (1 + (invoice.partial_invoice.pct / 100)) if invoice.partial_invoice
    projects.each do |project|
      total -= project.partial_invoice.amount * (1 + (project.partial_invoice.pct / 100)) if project.partial_invoice
    end
    total
  end

  def do_total_gross(invoice, projects)
    total = projects.collect { |p| p.valid? ? p.total_gross : 0 }.sum
    total += invoice.partial_invoice.amount if invoice.partial_invoice
    projects.each do |project|
      total -= project.partial_invoice.amount if project.partial_invoice
    end
    total
  end

  def update_statuses_invoice(invoice, company)

    if company == "PLUSVIEW"
      Project.all
             .where(status: :invoiced)
             .where("invoice_id IS NULL")
             .update(status: :accepted)
    else
      Project.all
             .where(status: :invoiced)
             .where("invoice_id IS NULL")
             .update(status: :done)
    end

    Ware.all
        .joins(:project)
        .where(status: :invoiced)
        .where("projects.invoice_id IS NULL")
        .update(status: :assigned_project)

    Service.all
           .joins(:project)
           .where(status: :invoiced)
           .where("projects.invoice_id IS NULL")
           .update(status: :assigned)

    invoice.projects.update(status: :invoiced)
    invoice.projects.each do |project|
      project.wares.update(status: :invoiced)
      project.services.update(status: :invoiced)
    end
  end

  def get_size(invoice)
    total = 0
    invoice.projects.each do |project|
      total += project.wares.count
      total += project.project_extra_lines.count
      project.services.each do |service|
        total += (service.name.length / 40).ceil
        total += (service.comment.length / 70).ceil
      end
    end
    total += (invoice.projects.count * 6)
  end

end
