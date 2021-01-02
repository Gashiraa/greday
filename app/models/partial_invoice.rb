class PartialInvoice < ApplicationRecord
  belongs_to :invoice
  belongs_to :project
end
