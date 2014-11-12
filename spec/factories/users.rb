FactoryGirl.define do 
  factory :user do 
    name "Test User"
    email "test@test.com.br" 
    password "teste123"
    password_confirmation "teste123" 
  end 
end