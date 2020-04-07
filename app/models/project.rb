# frozen_string_literal: true

class Project < ApplicationRecord

  include TranslateEnum

  belongs_to :customer, optional: true
  belongs_to :invoice, optional: true
  belongs_to :machine, optional: true

  has_one :quotation, dependent: :nullify

  belongs_to :customer, optional: true

  has_many :wares, dependent: :nullify
  has_many :services, dependent: :nullify

  has_many :project_extra_lines, dependent: :nullify
  has_many :extra, through: :project_extra_lines

  enum status: [:quotation, :in_progress, :done, :invoiced, :paid, :bin, :created, :accepted, :canceled]
  translate_enum :status

  def self.set_company(company)
    @company = company
  end

  def self.status_for_sort
    if @company == "PLUSVIEW" || "Philippe Doutrewé"
      options = ["Créé", 6, {status: "created"}],
          ["Accepté", 7, {status: "accepted"}],
          ["Facturé", 3, {status: "invoiced"}],
          ["Corbeille", 5, {status: "bin"}]
    else
      options = ["Devis", 0, {status: "quotation"}],
          ["En réalisation", 1, {status: "in_progress"}],
          ["Terminé", 2, {status: "done"}],
          ["Facturé", 3, {status: "invoiced"}],
          ["Payé", 4, {status: "paid"}],
          ["Corbeille", 5, {status: "bin"}]
    end
  end

  def self.status_for_form
    if @company == "PLUSVIEW" || "Philippe Doutrewé"
      options = ["Créé", "created", {status: "created"}],
          ["Accepté", "accepted", {status: "accepted"}],
          ["Facturé", "invoiced", {status: "invoiced"}],
          ["Corbeille", "bin", {status: "bin"}]
    else
      options = ["Devis", "quotation", {status: "quotation"}],
          ["En réalisation", "in_progress", {status: "in_progress"}],
          ["Terminé", "done", {status: "done"}],
          ["Facturé", "invoiced", {status: "invoiced"}],
          ["Payé", "paid", {status: "paid"}],
          ["Corbeille", "bin", {status: "bin"}]
    end
  end

  def update_totals_project(project)
    project.update(total: get_total, total_gross: get_total_gross)
  end

  def get_total
    wares.collect { |w| w.valid? ? w.total_cost : 0 }.sum +
        services.collect { |s| s.valid? ? s.total_cost : 0 }.sum +
        project_extra_lines.collect { |s| s.total }.sum
  end

  def get_total_gross
    wares.collect { |w| w.valid? ? w.total_gross : 0 }.sum +
        services.collect { |s| s.valid? ? s.total_gross : 0 }.sum +
        project_extra_lines.collect { |s| s.total_gross }.sum
  end

  def update_statuses_projects_content(project)
    if Project.statuses[project.status] == 3
      Ware.all.where(project_id: project.id).update(status: :invoiced)
      Service.all.where(project_id: project.id).update(status: :invoiced)
    end
  end
end