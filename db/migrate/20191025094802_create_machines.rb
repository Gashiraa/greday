class CreateMachines < ActiveRecord::Migration[5.2]
  def change
    create_table :machines do |t|
      t.string :model
      t.string :brand
      t.string :year
      t.integer :hours
      t.integer :km

      t.timestamps
    end
  end
end
