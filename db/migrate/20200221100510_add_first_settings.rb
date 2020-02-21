class AddFirstSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :use_services, :boolean, default: true
    add_column :companies, :use_wares, :boolean, default: true
    add_column :companies, :oto_invoice, :boolean, default: true
    add_column :companies, :use_manual_extras, :boolean, default: true
    add_column :companies, :use_articles, :boolean, default: true
  end
end
