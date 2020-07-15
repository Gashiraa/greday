class AddServicesRecap < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :services_recap, :boolean
  end
end