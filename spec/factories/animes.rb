# == Schema Information
#
# Table name: animes
#
#  id                  :integer          not null, primary key
#  name                :string
#  synopsis            :text
#  sessions            :integer
#  episodes            :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  tags                :hstore           is an Array
#  cover_file_name     :string
#  cover_content_type  :string
#  cover_file_size     :integer
#  cover_updated_at    :datetime
#  banner_file_name    :string
#  banner_content_type :string
#  banner_file_size    :integer
#  banner_updated_at   :datetime
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
