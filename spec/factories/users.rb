FactoryGirl.define do 
  factory :user do 
    sequence(:name) {|n| "User Test #{n}"}
    sequence(:email) {|n| "teste#{n}@teste.com.br"}
    password "teste123"
    password_confirmation "teste123" 
  end 
end