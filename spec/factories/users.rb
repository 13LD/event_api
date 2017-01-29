FactoryGirl.define do
  factory :user do
    name "Name"
    sequence(:email) { |n| "user#{n}@example.com" }
    password "testpass"
  end
end