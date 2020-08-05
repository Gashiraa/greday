class Machine < ApplicationRecord
  belongs_to :customer, optional: true

  has_many :project, dependent: :nullify
  has_many :ware, dependent: :nullify
  has_many :machine_histories, dependent: :nullify

  accepts_nested_attributes_for :machine_histories

end