class CorrectMachines < ActiveRecord::Migration[5.2]
  def change
    remove_column :machines, :hours
    remove_column :machines, :km
    add_column :machines, :category, :string
  end
end
