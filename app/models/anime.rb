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

class Anime < ApplicationRecord

  has_one_attached :cover

  validates :name, presence: true
  validates :synopsis, presence: true
  validates :sessions, presence: true
  validates :episodes, presence: true

  validates :name, uniqueness: true

  validates :name, length: { minimum: 5 }
  validates :synopsis, length: { minimum: 10 }

  validates :sessions, numericality: { only_integer: true }
  validates :episodes, numericality: { only_integer: true }

end
