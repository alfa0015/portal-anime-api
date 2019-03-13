# == Schema Information
#
# Table name: episodes
#
#  id         :bigint(8)        not null, primary key
#  anime_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Episode, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
