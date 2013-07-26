# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :prize do
    hop_name "MyString"
    jackpot 1
    place 1
    user nil
    hop nil
  end
end
