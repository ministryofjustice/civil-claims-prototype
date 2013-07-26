FactoryGirl.define do
  factory :person do
    title     "mr"
    full_name "joe bloggs"
    phone     "+44 (0)207 12345678"
    email     "email.address@example.com"
    
    postcode "sw1h 9aj"
    street_1 "102 Petty France"
    town "London"
  end
end