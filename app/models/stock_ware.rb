class StockWare < ApplicationRecord
  has_many :wares, dependent: :destroy
  has_many :projects, through: :wares
end
