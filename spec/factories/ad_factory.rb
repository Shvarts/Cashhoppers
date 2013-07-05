FactoryGirl.define do
  factory :ad do
    sequence(:ad_name){|i| "ad_#{i}"}
    hop_id nil
    contact 'contact data'
    phone '233-223-231'
    email nil
    ad_type nil
    price {rand(30)}
    factory :ad_with_hop do
      hop {FactoryGirl.create(:hop)}
    end
  end
end