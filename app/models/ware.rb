class Ware < ApplicationRecord
  include TranslateEnum

  belongs_to :project, optional: true
  belongs_to :invoice, optional: true
  belongs_to :customer, optional: true
  belongs_to :quotation, optional: true
  belongs_to :machine, optional: true

  enum status: [:not_assigned, :assigned_project, :assigned_customer, :invoiced, :paid]
  translate_enum :status

end