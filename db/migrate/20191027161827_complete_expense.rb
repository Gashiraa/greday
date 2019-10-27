class CompleteExpense < ActiveRecord::Migration[5.2]
  def change
    add_reference :expense_accounts,:customer, foreign_key: true
    add_column :expense_accounts, :date, :datetime
  end
end
