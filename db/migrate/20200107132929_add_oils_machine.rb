class AddOilsMachine < ActiveRecord::Migration[5.2]
  def change
    add_column :machines, :oils_text, :text
  end
end
