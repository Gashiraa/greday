class Machine < ApplicationRecord
  belongs_to :customer, optional: true
  has_many :ware, dependent: :nullify
  has_one :project, dependent: :nullify
end