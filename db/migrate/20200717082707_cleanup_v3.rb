class CleanupV3 < ActiveRecord::Migration[5.2]
  def change
    remove_column :services, :quotation_id, :string if column_exists? :services, :quotation_id
    remove_column :services, :invoice_id, :string if column_exists? :services, :invoice_id

    remove_column :wares, :quotation_id, :string if column_exists? :wares, :quotation_id
    remove_column :wares, :invoice_id, :string if column_exists? :wares, :invoice_id

    remove_column :invoices, :services_details_flag, :string if column_exists? :invoices, :services_details_flag

    remove_column :project_extra_lines, :manual_vat, :string if column_exists? :project_extra_lines, :manual_vat

    remove_column :projects, :wielding, :string if column_exists? :projects, :wielding
    remove_column :projects, :machining, :string if column_exists? :projects, :machining
    remove_column :projects, :karcher, :string if column_exists? :projects, :karcher

    drop_table :quotations
  end
end