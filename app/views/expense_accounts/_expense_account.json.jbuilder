json.extract! expense_account, :id, :reverse_invoice, :invoice_id, :description, :total_gross, :total, :created_at, :updated_at
json.url expense_account_url(expense_account, format: :json)
