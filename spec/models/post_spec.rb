# == Schema Information
#
# Table name: posts
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)
#  title      :string
#  body       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Post, type: :model do

  it{ should validate_presence_of(:title) }
  it{ should validate_presence_of(:body) }
  it{ should belong_to(:user) }

end
