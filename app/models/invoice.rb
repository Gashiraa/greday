# frozen_string_literal: true

class Invoice < ApplicationRecord
  include TranslateEnum

  belongs_to :payment, optional: true
  belongs_to :customer, optional: true

  has_many :projects, dependent: :nullify
  has_many :wares, dependent: :nullify
  has_many :expense_accounts, dependent: :nullify

  enum status: [:created, :paid]
  translate_enum :status

  def update_invoice_content_on_destroy(invoice)
    invoice.wares.update(status: :assigned_customer, invoice_id: nil)
    invoice.projects.update(status: :done, invoice_id: nil)

    invoice.projects.each do |project|
      project.wares.update(status: :assigned_project)
      project.services.update(status: :assigned)
    end
  end

  def update_totals_invoice(invoice, projects, wares)
    invoice.update(total: do_total(projects, wares),
                   total_gross: do_total_gross(projects, wares))
  end

  def do_total(projects, wares)
    wares.collect {|w| w.valid? ? w.total_cost : 0}.sum +
        projects.collect {|p| p.valid? ? p.total : 0}.sum
  end

  def do_total_gross(projects, wares)
    wares.collect {|w| w.valid? ? w.total_gross : 0}.sum +
        projects.collect {|p| p.valid? ? p.total_gross : 0}.sum
  end

  def update_statuses_invoice(invoice)

    Project.all
        .where(status: :invoiced)
        .where("invoice_id IS NULL")
        .update(status: :done)

    Ware.all
        .joins(:project)
        .where(status: :invoiced)
        .where("projects.invoice_id IS NULL")
        .update(status: :assigned_project)

    Ware.all
        .where(status: :invoiced)
        .where("invoice_id IS NULL")
        .where(project_id: nil)
        .update(status: :assigned_customer)

    Service.all
        .joins(:project)
        .where(status: :invoiced)
        .where("projects.invoice_id IS NULL")
        .update(status: :assigned)

    invoice.wares.update(status: :invoiced)
    invoice.projects.update(status: :invoiced)
    invoice.projects.each do |project|
      project.wares.update(status: :invoiced)
      project.services.update(status: :invoiced)
    end
  end

end
