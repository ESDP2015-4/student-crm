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

phonecodes = [550, 555, 559, 771, 772, 777, 543, 701, 705, 700]

5.times do
  User.create!(
      name: Faker::Name.name,
      surname: Faker::Name.last_name,
      middlename: Faker::Name.first_name,
      gender: ['male', 'female'].sample,
      birthdate: Faker::Date.backward,
      phone1: 0 + phonecodes.sample + rand(100000..999999),
      phone2: 0 + phonecodes.sample + rand(100000..999999),
      skype: Faker::Name.name,
      passportdetails: Faker::Lorem.word,

      #TODO after setting Devise
      # email:Faker::Internet.email,
      # password:password,
      # password_confirmation:password
  )
end
