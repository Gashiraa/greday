class AddDescSerialMachine < ActiveRecord::Migration[5.2]
  def change
    add_column :machines, :comment, :text
    add_column :machines, :serial, :string
  end
end
