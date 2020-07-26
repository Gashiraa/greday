class AddPosition < ActiveRecord::Migration[5.2]
  def change
    add_column :services, :position, :integer
    add_column :project_extra_lines, :position, :integer
  end
end
