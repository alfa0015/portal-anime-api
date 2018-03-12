json.extract! anime, :id, :name, :synopsis, :sessions, :episodes, :created_at, :updated_at
json.url api_v1_anime_url(anime, format: :json)
