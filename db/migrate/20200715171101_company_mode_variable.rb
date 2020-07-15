class CompanyModeVariable < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :mode, :string
  end
end