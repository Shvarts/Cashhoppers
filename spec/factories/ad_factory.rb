FactoryGirl.define do
  factory :ad do
    sequence(:ad_name){|i| "ad_#{i}"}
    hop_id nil
    contact 'contact data'
    phone 233223231
    sequence(:email){|i| "mail${i}@mail.com"}
    link_to_ad 'http://www.myadurl.com'
    amt 2
    ad_type 'sp'
    price {rand(30)}
    factory :ad_with_hop do
      hop {FactoryGirl.create(:hop)}
    end
  end
end