json.extract! machine_history, :id, :date, :amout, :machine_id, :created_at, :updated_at
json.url machine_history_url(machine_history, format: :json)
