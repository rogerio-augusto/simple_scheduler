# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(name: 'Admin', email: 'admin@simple-scheduler.com.br', password: 'admin1234', password_confirmation: 'admin1234', admin: true)
User.create(name: 'Derp', email: 'derp@simple-scheduler.com.br', password: 'derp1234', password_confirmation: 'derp1234')