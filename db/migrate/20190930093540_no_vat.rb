class NoVat < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :no_vat, :boolean
  end
end
