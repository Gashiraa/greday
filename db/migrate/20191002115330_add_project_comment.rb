class AddProjectComment < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :comment, :text
  end
end
