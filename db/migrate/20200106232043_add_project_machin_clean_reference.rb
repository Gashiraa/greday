class AddProjectMachinCleanReference < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :machine, index: true, foreign_key: true
  end
end
