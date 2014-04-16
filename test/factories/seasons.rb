# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :season do
    association     :player
    year            2012
    league          'NL'
    team            'SEA'
  end
end
