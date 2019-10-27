class CustomerMachineLine < ApplicationRecord
  belongs_to :customer
  belongs_to :machine

  has_one :project, dependent: :nullify
end
