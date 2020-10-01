class AddAutoCompleteSetting < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :autocomplete, :string
  end
end
