FactoryGirl.define do
  factory :user do
    sequence(:email){|i| "user#{i}@mail.com"}
    password '12345678'
    first_name 'Bob'
    last_name 'Vanish'
    zip 3123
    roles {[FactoryGirl.create(:role)]}
    factory :admin do
      roles {[FactoryGirl.create(:admin_role)]}
    end
  end


end