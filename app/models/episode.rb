# == Schema Information
#
# Table name: episodes
#
#  id         :bigint(8)        not null, primary key
#  anime_id   :bigint(8)
#  video_url  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Episode < ApplicationRecord
  belongs_to :anime
  has_one_attached :video
end
