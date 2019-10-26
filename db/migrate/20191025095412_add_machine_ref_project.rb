class AddMachineRefProject < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :customer_machine_line, index: true
  end
end
