class RenameOilType < ActiveRecord::Migration[5.2]
  def change
    rename_column :oils, :type, :oil_type
  end
end
