class ExpenseAccount < ApplicationRecord
  belongs_to :invoice, optional: true
  belongs_to :customer
end
