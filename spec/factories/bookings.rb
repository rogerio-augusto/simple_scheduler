FactoryGirl.define do
  factory :booking do
    association :user
    association :room
    date_and_time "2014-11-12 19:33:34"
  end
end
