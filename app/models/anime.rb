# == Schema Information
#
# Table name: animes
#
#  id                  :bigint(8)        not null, primary key
#  name                :string
#  synopsis            :text
#  sessions            :integer
#  episodes            :integer
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
#  video_url           :string
#

class Anime < ApplicationRecord

  has_one_attached :cover
  has_one_attached :banner

  validates :name, presence: true
  validates :synopsis, presence: true
  validates :sessions, presence: true
  validates :episodes, presence: true
  validates :video_url, presence: true

  validates :name, uniqueness: true

  validates :name, length: { minimum: 5 }
  validates :synopsis, length: { minimum: 10 }

  validates :sessions, numericality: { only_integer: true }
  validates :episodes, numericality: { only_integer: true }

  validates :cover, file_size: { less_than_or_equal_to: 500.kilobytes, message: 'avatar should be less than %{count}' },file_content_type: { allow: /^image\/.*/,message: 'the file has to be an image' }
  validates :banner, file_size: { less_than_or_equal_to: 500.kilobytes, message: 'avatar should be less than %{count}' },file_content_type: { allow: /^image\/.*/,message: 'the file has to be an image' }
end
