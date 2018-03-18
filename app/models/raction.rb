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

class Raction < ApplicationRecord
  belongs_to :rcontroller
end
