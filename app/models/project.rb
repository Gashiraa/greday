# frozen_string_literal: true

class Project < ApplicationRecord

  include TranslateEnum

  belongs_to :customer, optional: true
  belongs_to :invoice, optional: true

  has_one :quotation, dependent: :nullify
  has_one :customer_machine_line

  has_many :wares, dependent: :nullify
  has_many :services, dependent: :nullify

  has_many :project_extra_lines, dependent: :nullify
  has_many :extra, through: :project_extra_lines

  enum status: [:quotation, :in_progress, :done, :invoiced, :paid, :bin]
  translate_enum :status

  def update_totals_project(project)
    project.update(total: total, total_gross: total_gross)
  end

  def total
    wares.collect {|w| w.valid? ? w.total_cost : 0}.sum +
        services.collect {|s| s.valid? ? s.total_cost : 0}.sum +
        project_extra_lines.collect {|s| s.valid? ? s.total : 0}.sum
  end

  def total_gross
    wares.collect {|w| w.valid? ? w.total_gross : 0}.sum +
        services.collect {|s| s.valid? ? s.total_gross : 0}.sum +
        project_extra_lines.collect {|s| s.valid? ? s.total_gross : 0}.sum
  end

  def update_statuses_projects_content(project)
    if Project.statuses[project.status] == 3
      Ware.all.where(project_id: project.id).update(status: :invoiced)
      Service.all.where(project_id: project.id).update(status: :invoiced)
    end
  end
end
