# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

FactoryBot.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end
  factory :user do
    email
    password "password"
    password_confirmation "password"

    factory :user_donmy do
    	email
    	password "password"
    	password_confirmation "password"
    end
    factory :user_failer do
    	email
    	password "pass"
    	password_confirmation "pass"
    end
    factory :user_sequence do
        sequence(:email){ |n| "user#{n}@localhost.local" }
        password "password"
        password_confirmation "password"
    end
  end
end