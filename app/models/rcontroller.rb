# == Schema Information
#
# Table name: rcontrollers
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Rcontroller < ApplicationRecord
  has_many :ractions,dependent: :delete_all
  accepts_nested_attributes_for :ractions
end
