json.extract! rcontroller, :id, :name, :created_at, :updated_at
json.actions rcontroller.ractions
json.url api_v1_rcontroller_url(rcontroller, format: :json)
