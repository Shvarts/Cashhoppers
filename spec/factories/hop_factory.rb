FactoryGirl.define do
  factory :hop do
    sequence(:code){|i| "j1h3#{i}"}
    close false
    daily false
    price {rand(20)}
    jackpot 30
    sequence(:name){|i| "hop_#{i}"}
    producer_id 1
    time_start Time.now
    time_end Time.now + 8.hours
  end
end