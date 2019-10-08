class AddFlagQuotation < ActiveRecord::Migration[5.2]
  def change
    add_column :wares, :show_desc_quot, :boolean
  end
end
