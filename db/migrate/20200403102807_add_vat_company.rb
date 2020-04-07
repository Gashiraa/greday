class AddVatCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :vat, :string
  end
end
