class ExpenseAccount < ApplicationRecord
  belongs_to :invoice
  belongs_to :customer
end
