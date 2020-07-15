class AddShowSevices < ActiveRecord::Migration[5.2]
  def change
    add_column :services, :show_desc_invoice, :boolean
    add_column :services, :show_desc_quote, :boolean
    add_column :services, :is_displacement, :boolean
  end
end
