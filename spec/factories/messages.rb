# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    text "MyString"
    sender_id 1
    receiver_id 1
    shadule_date "2013-07-25 15:46:52"
    synchronized false
  end
end
