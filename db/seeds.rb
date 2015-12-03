# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
# #
# # Examples:
# #
# #   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
# #   Mayor.create(name: 'Emanuel', city: cities.first)
#
#
Role.create!(id: 1, name: 'student')
Role.create!(id: 2, name: 'manager')
Role.create!(id: 3, name: 'tutor')
Role.create!(id: 4, name: 'techsuport')
Role.create!(id: 5, name: 'admin')

phonecodes = (550..559).to_a
phonecodes.push (700..709).to_a
phonecodes.push (770..779).to_a
# phonecodes.push [543, 545] #I don't know if anyone is still using fonex
phonecodes.flatten!

password = 'password'

10.times do
  User.create!(
      name: Faker::Name.first_name,
      surname: Faker::Name.last_name,
      middlename: Faker::Name.first_name,
      gender: ['Мужчина', 'Женщина'].sample,
      birthdate: Faker::Date.backward,
      phone1: ('+996' + phonecodes.sample.to_s + rand(100000..999999).to_s),
      phone2: ('+996' + phonecodes.sample.to_s + rand(100000..999999).to_s),
      skype: ((Faker::Name.name.downcase!).split(' ')).join('_'),
      passportdetails: Faker::Lorem.word,
      email: "#{Faker::Name.first_name}.#{Faker::Name.last_name}@gmail.com",
      password: password,
      password_confirmation: password
  )
end

manager = User.create!(name: 'manager',
                       surname: 'manager',
                       gender: 'Мужчина',
                       birthdate: '02.09.1992',
                       phone1: '+996772180825',
                       phone2: '+996772180825',
                       skype: 'skype.daniyar',
                       passportdetails:'abijjljlk',
                       email: 'manager@gmail.com', password: password, password_confirmation: password)

manager.add_role 'manager'

student = User.create!(name: 'Student',
                       surname: 'Lastname',
                       gender: 'Мужчина',
                       birthdate: '02.09.1992',
                       phone1: '+996772180825',
                       phone2: '+996772180825',
                       skype: 'skype.daniyar',
                       passportdetails:'abijjljlk',
                       email: 'student@gmail.com', password: password, password_confirmation: password)

student.add_role 'student'

admin = User.create!(name: 'Admin',
                       surname: 'Lastname',
                       gender: 'Мужчина',
                       birthdate: '02.09.1992',
                       phone1: '+996772180825',
                       phone2: '+996772180825',
                       skype: 'skype.admin',
                       passportdetails:'MVD 50-01',
                       email: 'admin@gmail.com', password: password, password_confirmation: password)

admin.add_role 'admin'

tutor = User.create!(name: 'Tutor',
                       surname: 'Lastname',
                       gender: 'Мужчина',
                       birthdate: '02.09.1992',
                       phone1: '+996772180825',
                       phone2: '+996772180825',
                       skype: 'skype.tutor',
                       passportdetails:'MVD 50-01',
                       email: 'tutor@gmail.com', password: password, password_confirmation: password)

tutor.add_role 'tutor'

5.times do
  Course.create!(name: 'RoR',
  starts_at: '10.11.15',
  ends_at: '20.4.16')
end