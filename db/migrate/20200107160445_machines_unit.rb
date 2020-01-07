class MachinesUnit < ActiveRecord::Migration[5.2]
  def change
    remove_column :machines, :km
    remove_column :machines, :hours
    add_column :machines, :isKm, :boolean
  end
end
