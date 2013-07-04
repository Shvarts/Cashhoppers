FactoryGirl.define do
  factory :hop do
    sequence(:contact_email){|i| "example#{i}@mail.com"}
    contact_phone '123-212-212'
    sequence(:hop_code){|i| "j1h3#{i}"}
    hop_items nil
    hop_price {rand(20)}
    jackpot nil
    sequence(:name){|i| "hop_#{i}"}
    producer_contact nil
    producer_id nil
    time_start Time.now
    time_end Time.now + 1.days
  end
end