# == Schema Information
#
# Table name: ractions
#
#  id             :bigint(8)        not null, primary key
#  name           :string
#  rcontroller_id :bigint(8)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryBot.define do
  factory :raction do
    name {"MyString"}
  end
end
