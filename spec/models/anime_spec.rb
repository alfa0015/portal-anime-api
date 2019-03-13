# == Schema Information
#
# Table name: animes
#
#  id                  :bigint(8)        not null, primary key
#  name                :string
#  synopsis            :text
#  sessions            :integer
#  number_episodes     :integer
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
