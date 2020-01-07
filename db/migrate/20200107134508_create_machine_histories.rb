class CreateMachineHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :machine_histories do |t|
      t.date :date
      t.integer :amount
      t.references :machine, foreign_key: true

      t.timestamps
    end
  end
end
