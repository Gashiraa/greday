class AddShowDescQuotWares < ActiveRecord::Migration[5.2]
  def change
    unless column_exists? :wares, :show_desc_quot
      add_column :wares, :show_desc_quot, :boolean
    end
  end
end