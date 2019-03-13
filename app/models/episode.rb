# == Schema Information
#
# Table name: episodes
#
#  id         :bigint(8)        not null, primary key
#  anime_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Episode < ApplicationRecord
  belongs_to :anime
  has_one_attached :video
  after_create :ws_push_episode

  private
    def ws_push_episode
      ActionCable.server.broadcast(
        "episodes",
        episode: EpisodeSerializer.new(self).serialized_json
      )
    end
end
