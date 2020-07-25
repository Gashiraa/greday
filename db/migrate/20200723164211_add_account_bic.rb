class AddAccountBic < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :account, :string
    add_column :companies, :bic, :string
  end
end