class CleanupProjectsFk < ActiveRecord::Migration[5.2]
  def change
    remove_column :projects, :customer_machine_lines_id
    add_reference :projects, :customer_machine_line, foreign_key: true
  end
end
