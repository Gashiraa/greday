class CleanupFkProjects < ActiveRecord::Migration[5.2]
  def change
    remove_reference :projects, :customer_machine_line
    remove_index :projects, name: "index_projects_on_customer_machine_lines_id"
  end
end
