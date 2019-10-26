class AddTvAextraProjectLine < ActiveRecord::Migration[5.2]
  def change
    add_column :project_extra_lines, :tva_rate, :float
  end
end
