class AddVatNullProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :is_vat_null, :boolean
  end
end
