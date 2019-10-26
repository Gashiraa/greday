class AddCustomerRate < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :customer_rate, :float
  end
end
