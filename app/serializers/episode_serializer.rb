class EpisodeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :created_at

  attribute :anime do |episode|
    AnimeSerializer.new(episode.anime).as_json
  end
end
