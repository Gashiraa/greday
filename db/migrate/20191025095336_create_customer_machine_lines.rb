class CreateCustomerMachineLines < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_machine_lines do |t|
      t.references :customer, foreign_key: true
      t.references :machine, foreign_key: true
      t.integer :hours
      t.integer :km

      t.timestamps
    end
  end
end
