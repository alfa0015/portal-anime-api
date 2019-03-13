# == Schema Information
#
# Table name: animes
#
#  id                  :bigint(8)        not null, primary key
#  name                :string
#  synopsis            :text
#  sessions            :integer
#  number_episodes     :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  tags                :hstore           is an Array
#  cover_file_name     :string
#  cover_content_type  :string
#  cover_file_size     :bigint(8)
#  cover_updated_at    :datetime
#  banner_file_name    :string
#  banner_content_type :string
#  banner_file_size    :bigint(8)
#  banner_updated_at   :datetime
#

class AnimeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :synopsis, :sessions, :created_at, :updated_at
  attribute :cover_url do |anime|
    if Rails.env.development?
      Rails.application.routes.url_helpers.url_for(anime.cover)
    else
      anime.cover.service_url
    end
  end
  attribute :cover_medium_url do |anime|
    if Rails.env.development?
      Rails.application.routes.url_helpers.url_for(anime.cover.variant(resize: "400x400"))
    else
      anime.cover.variant(resize: "400x400").processed.service_url
    end
  end
  attribute :cover_small_url do |anime|
    if Rails.env.development?
      Rails.application.routes.url_helpers.url_for(anime.cover.variant(resize: "200x200"))
    else
      anime.cover.variant(resize: "200x200").processed.service_url
    end
  end
  attribute :banner_url do |anime|
    if Rails.env.development?
      Rails.application.routes.url_helpers.url_for(anime.banner)
    else
      anime.banner.service_url
    end
  end
  attribute :banner_medium_url do |anime|
    if Rails.env.development?
      Rails.application.routes.url_helpers.url_for(anime.banner.variant(resize: "400x400"))
    else
      anime.banner.variant(resize: "400x400").processed.service_url
    end
  end
  attribute :banner_small_url do |anime|
    if Rails.env.development?
      Rails.application.routes.url_helpers.url_for(anime.banner.variant(resize: "200x200"))
    else
      anime.banner.variant(resize: "200x200").processed.service_url
    end
  end
end
