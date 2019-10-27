class CreateExpenseAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :expense_accounts do |t|
      t.boolean :reverse_invoice
      t.references :invoice, foreign_key: true
      t.text :description
      t.float :total_gross
      t.float :total

      t.timestamps
    end
  end
end
