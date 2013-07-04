FactoryGirl.define do
  factory :role do
    name 'user'
    factory :admin_role do
      name 'admin'
    end
  end
end