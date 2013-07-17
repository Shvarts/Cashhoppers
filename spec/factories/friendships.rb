# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :friendship do
    user_id 1
    friend_id 1
    status "MyString"
    created_at "2013-07-15 10:07:24"
    accepted_at "2013-07-15 10:07:24"
  end
end
