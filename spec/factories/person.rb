FactoryGirl.define :person do |person|
  full_name "joe bloggs"
  phone     "+44 (0)207 12345678"
  email     "email.address@example.com"
  person.after_create { |p| Factory(:address, profile: p)}
end