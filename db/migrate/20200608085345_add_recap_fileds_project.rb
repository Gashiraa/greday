class AddRecapFiledsProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :services_recap_text, :text
    add_column :projects, :displacement_recap, :text
  end
end