class Customer < ApplicationRecord
  has_many :invoices, dependent: :nullify
  has_many :quotations, dependent: :nullify
  has_many :payments, dependent: :nullify
  has_many :projects, dependent: :nullify
end