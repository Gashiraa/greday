class AddFkProjectCustomerMachineLine < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :customer_machine_line, index: true
    add_foreign_key :projects, :customer_machine_lines
  end
end
