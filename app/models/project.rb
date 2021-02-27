# frozen_string_literal: true

class Project < ApplicationRecord
  include TranslateEnum

  belongs_to :customer, optional: true
  belongs_to :invoice, optional: true
  belongs_to :machine, optional: true

  has_many :wares, dependent: :nullify
  has_many :services, dependent: :nullify

  has_many :project_extra_lines, dependent: :nullify
  has_many :extra, through: :project_extra_lines

  has_one :partial_invoice, dependent: :nullify

  accepts_nested_attributes_for :machine

  enum status: %i[quotation in_progress done verified invoiced paid bin created accepted dropped]
  translate_enum :status

  def self.set_company(company)
    @company = company
  end

  def self.status_for_sort
    options = if @company == 'Plusview'
                [['Créé', 7, { status: 'created' }],
                 ['Accepté', 8, { status: 'accepted' }],
                 ['Facturé', 4, { status: 'invoiced' }],
                 ['Corbeille', 6, { status: 'bin' }]]
              else
                [['Devis', 0, { status: 'quotation' }],
                 ['En réalisation', 1, { status: 'in_progress' }],
                 ['Terminé', 2, { status: 'done' }],
                 ['Vérifié', 3, { status: 'verified' }],
                 ['Facturé', 4, { status: 'invoiced' }],
                 ['Payé', 5, { status: 'paid' }],
                 ['Corbeille', 6, { status: 'bin' }],
                 ['Sans suite', 9, { status: 'dropped' }]]
              end
  end

  def self.status_for_form
    options = if @company == 'Plusview'
                [['Créé', 'created', { status: 'created' }],
                 ['Accepté', 'accepted', { status: 'accepted' }],
                 ['Facturé', 'invoiced', { status: 'invoiced' }],
                 ['Corbeille', 'bin', { status: 'bin' }]]
              else
                [['Devis', 'quotation', { status: 'quotation' }],
                 ['En réalisation', 'in_progress', { status: 'in_progress' }],
                 ['Terminé', 'done', { status: 'done' }],
                 ['Vérifié', 'verified', { status: 'verified' }],
                 ['Facturé', 'invoiced', { status: 'invoiced' }],
                 ['Payé', 'paid', { status: 'paid' }],
                 ['Corbeille', 'bin', { status: 'bin' }],
                 ['Sans suite', 'dropped', { status: 'dropped' }]]
              end
  end

  def update_totals_project(project)
    project.update(total: get_total, total_gross: get_total_gross)
    project.update(total: 0, total_gross: 0) if project.total.nil?
  end

  def get_total
    wares.sum(:total_cost) +
      services.sum(:total_cost) +
      project_extra_lines.sum(:total)
  end

  def get_total_gross
    wares.sum(:total_gross) +
      services.sum(:total_gross) +
      project_extra_lines.sum(:total_gross)
  end

  def update_statuses_projects_content(project)
    if Project.statuses[project.status] == 3
      Ware.all.where(project_id: project.id).update(status: :invoiced)
      Service.all.where(project_id: project.id).update(status: :invoiced)
    end
  end

  def customer_name
    customer.name
  end

  def name_and_id
    "#{name} - #{id}"
  end

  def project_name_and_customer_name
    if customer
      "#{name} - #{customer&.name}"
    else
      name.to_s
    end
  end
end
