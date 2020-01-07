class DeleteMachineLines < ActiveRecord::Migration[5.2]
  def change
    drop_table :customer_machine_lines, force: :cascade
  end
end
