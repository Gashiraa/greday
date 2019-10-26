class ManuelExtra < ActiveRecord::Migration[5.2]
  def change
    add_column :project_extra_lines, :is_manual, :boolean
    add_column :project_extra_lines, :manual_name, :string
    add_column :project_extra_lines, :manual_price, :float
    add_column :project_extra_lines, :unit, :string
    add_column :project_extra_lines, :manual_vat, :string

  end
end
