class ChangeVatExtra < ActiveRecord::Migration[5.2]
  def change
    remove_column :project_extra_lines, :manual_vat
    add_column :project_extra_lines, :manual_vat, :float
  end
end
