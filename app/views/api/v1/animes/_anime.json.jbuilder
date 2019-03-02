json.extract! anime, :id, :name, :synopsis, :sessions, :episodes, :video_url ,:tags, :created_at, :updated_at
if Rails.env.development?
  json.cover_url Rails.application.routes.url_helpers.url_for(anime.cover)
else
  json.cover_url anime.cover.service_url
end
if Rails.env.development?
  json.cover_medium_url Rails.application.routes.url_helpers.url_for(anime.cover.variant(resize: "400x400"))
else
  json.cover_medium_url anime.cover.variant(resize: "400x400").processed.service_url
end
if Rails.env.development?
  json.cover_small_url Rails.application.routes.url_helpers.url_for(anime.cover.variant(resize: "200x200"))
else
  json.cover_small_url anime.cover.variant(resize: "200x200").processed.service_url
end
if Rails.env.development?
  json.banner_url Rails.application.routes.url_helpers.url_for(anime.banner)
else
  json.banner_url anime.banner.service_url
end
if Rails.env.development?
  json.banner_medium_url Rails.application.routes.url_helpers.url_for(anime.banner.variant(resize: "400x400"))
else
  json.banner_medium_url anime.banner.variant(resize: "400x400").processed.service_url
end
if Rails.env.development?
  json.banner_small_url Rails.application.routes.url_helpers.url_for(anime.banner.variant(resize: "200x200"))
else
  json.banner_small_url anime.banner.variant(resize: "200x200").processed.service_url
end
json.url api_v1_anime_url(anime, format: :json)
