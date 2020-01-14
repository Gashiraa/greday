class ChangeQtyFloat < ActiveRecord::Migration[5.2]
  def change
    change_column :wares, :quantity, :float
  end
end
