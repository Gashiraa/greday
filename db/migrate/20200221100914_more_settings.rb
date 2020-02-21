class MoreSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :use_machines, :boolean, default: true
    add_column :companies, :use_credit_notes, :boolean, default: true
  end
end
