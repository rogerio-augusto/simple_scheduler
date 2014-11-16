FactoryGirl.define do
  factory :meeting do
    association :user
    starts_at "2014-11-12 19:33:34"
  end
end
