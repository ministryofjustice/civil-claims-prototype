FactoryGirl.define do
  factory :person do
    full_name "joe bloggs"
    phone     "+44 (0)207 12345678"
    email     "email.address@example.com"
    
    association :address, factory: :address, strategy: :build
  end
end