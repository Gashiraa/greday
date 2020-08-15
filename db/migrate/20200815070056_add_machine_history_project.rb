class AddMachineHistoryProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :machine_history, :integer
  end
end
