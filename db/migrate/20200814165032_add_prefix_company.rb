class AddPrefixCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :prefix, :string
  end
end
