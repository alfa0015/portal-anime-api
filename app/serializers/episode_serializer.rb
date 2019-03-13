# == Schema Information
#
# Table name: episodes
#
#  id         :bigint(8)        not null, primary key
#  anime_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EpisodeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :created_at, :updated_at

  attribute :video_url do |episode|
    if Rails.env.development?
      Rails.application.routes.url_helpers.url_for(episode.video)
    else
      episode.video.service_url
    end
  end

  attribute :anime do |episode|
    AnimeSerializer.new(episode.anime).as_json
  end
end
