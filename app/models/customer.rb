class Customer < ApplicationRecord
  has_many :invoices, dependent: :nullify
  has_many :payments, dependent: :nullify
  has_many :projects, dependent: :nullify
  has_many :machines, dependent: :nullify
  has_many :expense_accounts, dependent: :nullify
end