class DropVatNull < ActiveRecord::Migration[5.2]
  def change
    remove_column :projects, :is_vat_null
  end
end
