class AddPoAndOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :po, :string
    add_column :projects, :applicant, :string
  end
end
