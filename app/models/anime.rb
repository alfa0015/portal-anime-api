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

class Anime < ApplicationRecord

  validates :name, presence: true
  validates :synopsis, presence: true
  validates :sessions, presence: true
  validates :episodes, presence: true

  validates :name, uniqueness: true

  validates :name, length: { in: 10..20 }
  validates :synopsis, length: { minimum: 10 }

  validates :sessions, numericality: { only_integer: true }
  validates :episodes, numericality: { only_integer: true }
end
