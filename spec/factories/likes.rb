# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :like do
    user_id 1
    target_object_id 1
    target_object "MyString"
  end
end
