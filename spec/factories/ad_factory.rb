FactoryGirl.define do
  factory :ad do
    advert_id {FactoryGirl.create(:user).id}
    sequence(:advertiser_name){|i| "ad_#{i}"}
    hop_id nil
    contact 'contact data'
    phone '233-223-231'
    email nil
    type_add nil
    price {rand(30)}
    amd_paid nil
    factory :ad_with_hop do
      hop []
    end
  end
end