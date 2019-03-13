# == Schema Information
#
# Table name: episodes
#
#  id         :bigint(8)        not null, primary key
#  anime_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :episode do
    anime { nil }
    video_url { "MyString" }
  end
end
