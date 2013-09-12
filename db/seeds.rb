# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

c = Claimant.create({
  full_name: 'John Smith Reynolds',
  phone: '0207 613 4431',
  mobile: '07792 685998',
  email: 'jsreynolds@btconnect.com',
  uj: true
})
c.create_address({
  street_1: '121 Elm Park Road',
  town: 'London',
  postcode: 'SW1 1SZ'
})

d = Defendant.create({
  full_name: 'Louis Robert Stevenson',
  phone: '0208 123 6789',
  mobile: '07765 912673',
  email: 'lrsteveson@hotmail.co.uk',
  uj: true
})
d.create_address({
  street_1: 'Flat 3',
  street_2: '92 Crystal Palace Park Road',
  town: 'London',
  postcode: 'SE26 6UP'
})

Staff.create(Person.generate)
Judge.create(Person.generate)