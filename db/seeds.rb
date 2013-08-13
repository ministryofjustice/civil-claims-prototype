# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Claimant.create({
  title: 'Mr',
  full_name: 'John Smith Reynolds',
  phone: '+44 (0)207 613 4431',
  mobile: '+44 (0)7792 685998',
  email: 'jsreynolds@btconnect.com',
  address: Address.create({
    street_1: '121 Elm Park Road',
    town: 'London',
    postcode: 'SW1 1SZ'
    })
  })
Defendant.create(Person.generate)
Staff.create(Person.generate)
Judge.create(Person.generate)