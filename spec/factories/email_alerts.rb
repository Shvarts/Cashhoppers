# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :email_alert do
    text "MyText"
    sender_id 1
    receiver_id 1
    schedule_date "2013-07-25 15:51:02"
    subject "MyString"
    template_id 1
  end
end
