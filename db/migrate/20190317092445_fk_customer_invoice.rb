class FkCustomerInvoice < ActiveRecord::Migration[5.2]
  def change
    #add_reference :invoices, :customer, index: true
    #add_foreign_key :invoices, :customers
  end
end