# == Schema Information
#
# Table name: tvshows
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  synopsis   :string
#  episodes   :integer          default(0), not null
#  seasons    :integer          default(1), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tags       :hstore
#

class Tvshow < ApplicationRecord

end
