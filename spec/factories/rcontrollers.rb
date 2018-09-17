# == Schema Information
#
# Table name: rcontrollers
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :rcontroller do
    name {"MyString"}
  end
end
