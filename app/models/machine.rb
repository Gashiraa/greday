class Machine < ApplicationRecord
  belongs_to :customer, optional: true

  has_many :projects, dependent: :nullify
  has_many :wares, dependent: :nullify

end