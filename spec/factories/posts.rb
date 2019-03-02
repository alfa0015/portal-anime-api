# == Schema Information
#
# Table name: posts
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)
#  title      :string
#  body       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :post do
    title {"Post"}
    body {"Post body"}
    association :user, factory: :user
  end
end
