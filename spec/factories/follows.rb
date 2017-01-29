FactoryGirl.define do
  factory :follow do
    followable_type "Event"               
    followable_id 1
    follower_type "User"
    follower_id 1
  end
end