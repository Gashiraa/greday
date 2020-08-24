class CreateOils < ActiveRecord::Migration[5.2]
  def change
    create_table :oils do |t|
      t.references :machine, foreign_key: true
      t.string :category
      t.string :type
      t.string :quantity

      t.timestamps
    end
  end
end
