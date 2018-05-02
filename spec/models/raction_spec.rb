# == Schema Information
#
# Table name: ractions
#
#  id             :integer          not null, primary key
#  name           :string
#  rcontroller_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Raction, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
