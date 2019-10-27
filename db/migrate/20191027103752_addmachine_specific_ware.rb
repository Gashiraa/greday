class AddmachineSpecificWare < ActiveRecord::Migration[5.2]
  def change
    add_column :wares, :machine_specific, :boolean
  end
end
