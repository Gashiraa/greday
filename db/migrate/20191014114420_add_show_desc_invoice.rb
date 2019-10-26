class AddShowDescInvoice < ActiveRecord::Migration[5.2]
  def change
    add_column :wares, :show_desc_invoice, :boolean
  end
end
