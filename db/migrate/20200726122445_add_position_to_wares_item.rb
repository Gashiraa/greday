class AddPositionToWaresItem < ActiveRecord::Migration[5.2]
  def change
    add_column :wares, :position, :integer
  end
end
