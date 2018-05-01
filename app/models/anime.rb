# == Schema Information
#
# Table name: animes
#
#  id                 :integer          not null, primary key
#  name               :string
#  synopsis           :text
#  sessions           :integer
#  episodes           :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  tags               :hstore           is an Array
#  cover_file_name    :string
#  cover_content_type :string
#  cover_file_size    :integer
#  cover_updated_at   :datetime
#

class Anime < ApplicationRecord

  has_attached_file :cover, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"

  validates :name, presence: true
  validates :synopsis, presence: true
  validates :sessions, presence: true
  validates :episodes, presence: true
  validates :cover, presence: true

  validates :name, uniqueness: true

  validates :name, length: { minimum: 5 }
  validates :synopsis, length: { minimum: 10 }

  validates :sessions, numericality: { only_integer: true }
  validates :episodes, numericality: { only_integer: true }

  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\z/
end
