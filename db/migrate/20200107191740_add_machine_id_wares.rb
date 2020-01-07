class AddMachineIdWares < ActiveRecord::Migration[5.2]
  def change
    add_reference :wares, :machine, foreign_key: true, index: true
  end
end