# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Role.create!(id: 1, rolename:'student')
Role.create!(id: 2, rolename:'manager')
Role.create!(id: 3, rolename:'tutor')
Role.create!(id: 4, rolename:'techsuport')
Role.create!(id: 5, rolename:'admin')

password = 'password'

User.create!(name:'John', surname:'Doe',email:'john@test.com', password:password, password_confirmation:password)