class AddStartEndService < ActiveRecord::Migration[5.2]
  def change
    add_column :services, :start_time, :time
    add_column :services, :end_time, :time
  end
end
