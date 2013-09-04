FactoryGirl.define :claimant do |claimant|
  full_name "joe bloggs"
  phone     "+44 (0)207 12345678"
  email     "email.address@example.com"
  claimant.after_create { |c| Factory(:address, profile: c)}
end