json.extract! tvshow, :id, :name, :tags,:created_at, :updated_at
json.url api_v1_tvshow_url(tvshow, format: :json)
