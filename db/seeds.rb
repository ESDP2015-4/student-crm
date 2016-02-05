
Role.create!(id: 1, name: 'student')
Role.create!(id: 2, name: 'manager')
Role.create!(id: 3, name: 'teacher')
Role.create!(id: 4, name: 'techsupport')
Role.create!(id: 5, name: 'admin')

StudyUnit.create!(title:'Первый')
StudyUnit.create!(title:'Второй')
StudyUnit.create!(title:'Третий')
StudyUnit.create!(title:'Четвертый')
StudyUnit.create!(title:'Пятый')


phonecodes = (550..559).to_a
phonecodes.push (700..709).to_a
phonecodes.push (770..779).to_a
# phonecodes.push [543, 545] #I don't know if anyone is still using fonex
phonecodes.flatten!

password = 'password'

#creating students
50.times do
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
      password_confirmation: password,
      roles:[Role.find_by(name:'student')]
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

teacher = User.create!(name: 'Teacher',
                     surname: 'Lastname',
                     gender: 'Мужчина',
                     birthdate: '02.09.1992',
                     phone1: '+996772180825',
                     phone2: '+996772180825',
                     skype: 'skype.tutor',
                     passportdetails:'MVD 50-01',
                     email: 'teacher@gmail.com', password: password, password_confirmation: password)

teacher.add_role 'teacher'

support = User.create!(name: 'Tech',
                     surname: 'Support',
                     gender: 'Мужчина',
                     birthdate: '02.09.1992',
                     phone1: '+996772180825',
                     phone2: '+996772180825',
                     skype: 'skype.tutor',
                     passportdetails:'MVD 50-01',
                     email: 'techsupport@gmail.com', password: password, password_confirmation: password)

support.add_role 'techsupport'

element_types = ['Лекция', 'Вебинар', 'Лабараторка', 'Контрольная']

student_id = 0
5.times do
  course = Course.create!(name: "#{Faker::Hacker.adjective.capitalize} #{Faker::Hacker.noun.capitalize}")

  10.times do
    ce = CourseElement.create!(
        theme:"#{Faker::Hacker.ingverb.capitalize} #{Faker::Hacker.abbreviation.capitalize}",
        course: course,
        element_type: element_types.sample,
        # content: Faker::Lorem.paragraphs(5).join
    )
  end

  gr_num = 0
  2.times do
    gr_num += 1
    group = Group.create!(
        #this takes first letter of each word
        name: "#{course.name.split.map(&:first).join} GR#{gr_num}",
        course: course
    )

    #create GroupMembership for this group
    5.times do
      #increment student_id to get different student ids
      student_id += 1
      GroupMembership.create!(
          group: group,
          user_id: student_id,
          active: true)
    end

    TeachersGroup.create!(group: group,
          user_id: teacher.id,
          active: true)

    SupportsGroup.create!(group: group,
          user_id: support.id,
          active: true)

  end
end

######################### start of period seeds ###############

groups = Group.all
t = Time.now
t = t.at_midday


def set_week_day(time)
  case time.wday
    when 1 then time + 2.days
    when 3 then time + 2.days
    when 5 then time + 3.days
    when 2 then time + 2.days
    when 4 then time + 2.days
    when 6 then time + 3.days
    else time + 1.days
  end
end

def set_hour(time)
  case time.hour
    when 12 then time + 2.hours
    when 14 then time + 2.hours
    when 18 then time + 2.hours
    else time.at_midday
  end
end

groups.each do |group|
  c_el_id = 0
  t -= 20.days
  10.times do
    t = set_week_day(t)
    c_el_id += 1
    Period.create!(
        title:"Lesson #{c_el_id}",
        group_id: group.id,
        course_id: group.course_id,
        course_element_id: c_el_id,
        commence_datetime: t
    )
  end
  t = set_hour(t)

end

########################## end of period seeds ####################