class AlterMachines < ActiveRecord::Migration[5.2]
  def change
    add_column :machines, :hours, :integer
    add_column :machines, :km, :integer
    add_reference :machines, :customer, index: true
    add_foreign_key :machines, :customers
  end
end