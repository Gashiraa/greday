class UseManualInvoiceNumber < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :use_manual_invoice_number, :boolean, default: true
  end
end
