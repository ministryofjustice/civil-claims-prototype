FactoryGirl.define do
  factory :person do
    address
    title     "mr"
    full_name "joe bloggs"
    phone     "+44 (0)207 12345678"
    email     "email.address@example.com"
  end
end