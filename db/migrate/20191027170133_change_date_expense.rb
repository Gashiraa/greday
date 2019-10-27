class ChangeDateExpense < ActiveRecord::Migration[5.2]
  def change
    change_column :expense_accounts, :date, :date
  end
end
