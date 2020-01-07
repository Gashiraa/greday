class AddMaintenanceWareFlag < ActiveRecord::Migration[5.2]
  def change
    add_column :wares, :is_maintenance, :boolean
  end
end
