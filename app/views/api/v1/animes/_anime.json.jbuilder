json.extract! anime, :id, :name, :synopsis, :sessions, :episodes, :tags, :created_at, :updated_at
json.cover_url asset_url(anime.cover.url)
json.cover_medium_url asset_url(anime.cover.url(:medium))
json.cover_small_url asset_url(anime.cover.url(:small))
json.cover_thumb_url asset_url(anime.cover.url(:thumb))
json.url api_v1_anime_url(anime, format: :json)
