# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player do
    player_id "MyString"
    birth_year 1
    first_name "MyString"
    last_name "MyString"
  end
end
