class AddProviderServices < ActiveRecord::Migration[5.2]
  def change
    add_column :services, :provider, :string
  end
end