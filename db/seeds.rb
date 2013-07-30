# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(title: 'Mr', full_name: 'Micky Mouse', phone: '07890 123456', street_1: '123 Madeup Lane', town: 'London', postcode: 'N1 1AB' )
User.create(title: 'Mr', full_name: 'Bugs Bunny', phone: '0207 888222', street_1: '2 Nota Street', town: 'London', postcode: 'SW1 9ZZ' )