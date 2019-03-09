json.extract! episode, :id, :created_at, :updated_at
json.anime do
  json.name episode.anime.name
  json.synopsis episode.anime.synopsis
  json.sessions episode.anime.sessions
  json.episodes episode.anime.episodes
  json.created_at episode.anime.created_at
  json.updated_at episode.anime.updated_at
  if Rails.env.development?
    json.cover_url Rails.application.routes.url_helpers.url_for(episode.anime.cover)
  else
    json.cover_url episode.anime.cover.service_url
  end
  if Rails.env.development?
    json.cover_medium_url Rails.application.routes.url_helpers.url_for(episode.anime.cover.variant(resize: "400x400"))
  else
    json.cover_medium_url episode.anime.cover.variant(resize: "400x400").processed.service_url
  end
  if Rails.env.development?
    json.cover_small_url Rails.application.routes.url_helpers.url_for(episode.anime.cover.variant(resize: "200x200"))
  else
    json.cover_small_url episode.anime.cover.variant(resize: "200x200").processed.service_url
  end
  if Rails.env.development?
    json.banner_url Rails.application.routes.url_helpers.url_for(episode.anime.banner)
  else
    json.banner_url episode.anime.banner.service_url
  end
  if Rails.env.development?
    json.banner_medium_url Rails.application.routes.url_helpers.url_for(episode.anime.banner.variant(resize: "400x400"))
  else
    json.banner_medium_url episode.anime.banner.variant(resize: "400x400").processed.service_url
  end
  if Rails.env.development?
    json.banner_small_url Rails.application.routes.url_helpers.url_for(episode.anime.banner.variant(resize: "200x200"))
  else
    json.banner_small_url episode.anime.banner.variant(resize: "200x200").processed.service_url
  end
  json.url api_v1_anime_url(episode.anime, format: :json)
  
end
if Rails.env.development?
  json.video_url Rails.application.routes.url_helpers.url_for(episode.video)
else
  json.video_url episode.video.service_url
end
# json.url api_v1_anime_episode_url(episode, format: :json)