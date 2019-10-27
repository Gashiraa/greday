class Machine < ApplicationRecord
  has_many :customer_machine_lines, dependent: :destroy
  has_many :customers, through: :customer_machine_lines
end
