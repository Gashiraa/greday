class CleanupProjectMachines < ActiveRecord::Migration[5.2]
  def change
    remove_reference :projects, :customer_machine_line, index: true
  end
end
