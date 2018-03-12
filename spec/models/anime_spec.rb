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
#

require 'rails_helper'

RSpec.describe Anime, type: :model do
  it{ should validate_presence_of(:name) }
  it{ should validate_presence_of(:synopsis) }
  it{ should validate_presence_of(:sessions) }
  it{ should validate_presence_of(:episodes) }

  it{ should validate_uniqueness_of(:name) }

  it{ should validate_length_of(:name).is_at_least(10).on(:create) }
  it{ should validate_length_of(:name).is_at_most(20).on(:create) }
  it{ should validate_length_of(:synopsis).is_at_least(10).on(:create) }

  it { should validate_numericality_of(:sessions).only_integer }
  it { should validate_numericality_of(:episodes).only_integer }

end
