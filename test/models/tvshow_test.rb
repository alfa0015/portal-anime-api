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

require 'test_helper'

class TvshowTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
