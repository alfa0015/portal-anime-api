# == Schema Information
#
# Table name: animes
#
#  id         :integer          not null, primary key
#  name       :string
#  synopsis   :text
#  sessions   :integer
#  episodes   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tags       :hstore           is an Array
#

FactoryBot.define do
  factory :anime do
    sequence :name do |n|
      "MyString string#{n}"
    end
    synopsis "MyText text text"
    sessions 1
    episodes 1
  end
end
