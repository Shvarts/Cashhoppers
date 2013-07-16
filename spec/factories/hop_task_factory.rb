FactoryGirl.define do
  factory :hop_task do
    text 'task description'
    sponsor_id 1
    price {rand(30)}
    pts 5
    bonus 40
    amt 2
  end
end
