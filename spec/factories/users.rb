FactoryGirl.define do 
  factory :user do 
    name "Test User"
    sequence(:email) {|n| "teste#{n}@teste.com.br"}
    password "teste123"
    password_confirmation "teste123" 
  end 
end