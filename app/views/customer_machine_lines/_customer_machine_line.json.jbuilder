json.extract! customer_machine_line, :id, :customer_id, :machine_id, :hours, :km, :created_at, :updated_at
json.url customer_machine_line_url(customer_machine_line, format: :json)
