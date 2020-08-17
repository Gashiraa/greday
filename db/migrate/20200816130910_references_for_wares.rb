class ReferencesForWares < ActiveRecord::Migration[5.2]
  def change
    rename_column  :wares, :provider_name, :provider_1
    rename_column  :wares, :provider_invoice, :reference_1
    add_column :wares, :provider_2, :string
    add_column :wares, :reference_2, :string
    add_column :wares, :provider_3, :string
    add_column :wares, :reference_3, :string
  end
end