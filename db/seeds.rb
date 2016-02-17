
# Create roles
Role.create!(id: 1, name: 'student')
Role.create!(id: 2, name: 'manager')
Role.create!(id: 3, name: 'teacher')
Role.create!(id: 4, name: 'techsupport')
Role.create!(id: 5, name: 'admin')

# Create study units
StudyUnit.create!(title:'Первый')
StudyUnit.create!(title:'Второй')
StudyUnit.create!(title:'Третий')
StudyUnit.create!(title:'Четвертый')
StudyUnit.create!(title:'Пятый')

# # Create phone codes
# phonecodes = (550..559).to_a
# phonecodes.push (700..709).to_a
# phonecodes.push (770..779).to_a
# phonecodes.flatten!

# Default password for test users
password = 'password'

# # Creating students
# 50.times do
#   User.create!(
#       name: Faker::Name.first_name,
#       surname: Faker::Name.last_name,
#       middlename: Faker::Name.first_name,
#       gender: ['Мужчина', 'Женщина'].sample,
#       birthdate: Faker::Date.backward,
#       phone1: ('+996' + phonecodes.sample.to_s + rand(100000..999999).to_s),
#       phone2: ('+996' + phonecodes.sample.to_s + rand(100000..999999).to_s),
#       skype: ((Faker::Name.name.downcase!).split(' ')).join('_'),
#       passportdetails: Faker::Lorem.word,
#       email: "#{Faker::Name.first_name}.#{Faker::Name.last_name}@gmail.com",
#       password: password,
#       password_confirmation: password,
#       roles:[Role.find_by(name:'student')]
#   )
# end

# Test user with manager role
user1 = User.create!(name: 'Altyn',
                       surname: 'manager',
                       gender: 'Мужчина',
                       birthdate: '02.09.1972',
                       phone1: '+996555180825',
                       phone2: '+996555180825',
                       skype: 'skype.afdgsa',
                       passportdetails:'abijjljlk',
                       email: 'altiwbek@gmail.com', password: password, password_confirmation: password)

user1.add_role 'admin'

user2 = User.create!(name: 'Amir',
                       surname: 'manager',
                       gender: 'Мужчина',
                       birthdate: '02.09.1992',
                       phone1: '+996772187825',
                       phone2: '+996772184525',
                       skype: 'skype.were',
                       passportdetails:'asdfdsafsaf',
                       email: 'a.mullabaev@gmail.com', password: password, password_confirmation: password)

user2.add_role 'admin'


user3 = User.create!(name: 'Roma',
                       surname: 'manager',
                       gender: 'Мужчина',
                       birthdate: '02.09.1992',
                       phone1: '+996772100825',
                       phone2: '+996772114525',
                       skype: 'skypiyut.were',
                       passportdetails:'asdfdsafsaf',
                       email: 'ramablack93@gmail.com', password: password, password_confirmation: password)

user3.add_role 'admin'

user4 = User.create!(name: 'Max',
                       surname: 'manager',
                       gender: 'Мужчина',
                       birthdate: '02.09.1992',
                       phone1: '+996772100000',
                       phone2: '+996772111111',
                       skype: 'skypejuere',
                       passportdetails:'asdfdsafsaf',
                       email: 'sabyrov@gmail.com', password: password, password_confirmation: password)

user4.add_role 'admin'

# Test user with a student role
# student = User.create!(name: 'Student',
#                        surname: 'Lastname',
#                        gender: 'Мужчина',
#                        birthdate: '02.09.1992',
#                        phone1: '+996772180825',
#                        phone2: '+996772180825',
#                        skype: 'skype.daniyar',
#                        passportdetails:'abijjljlk',
#                        email: 'student@gmail.com', password: password, password_confirmation: password)
#
# student.add_role 'student'

# Test user with an admin role
user5 = User.create!(name: 'Admin',
                     surname: 'Lastname',
                     gender: 'Мужчина',
                     birthdate: '02.09.1992',
                     phone1: '+996772180725',
                     phone2: '+996772190825',
                     skype: 'skype.admin',
                     passportdetails:'MVD 50-01',
                     email: 'shamkeev@gmail.com', password: password, password_confirmation: password)

user5.add_role 'admin'

# # Test user with a teacher role
# teacher = User.create!(name: 'Teacher',
#                      surname: 'Lastname',
#                      gender: 'Мужчина',
#                      birthdate: '02.09.1992',
#                      phone1: '+996772180825',
#                      phone2: '+996772180825',
#                      skype: 'skype.tutor',
#                      passportdetails:'MVD 50-01',
#                      email: 'teacher@gmail.com', password: password, password_confirmation: password)
#
# teacher.add_role 'teacher'

# # Test user with a techsupport role
# support = User.create!(name: 'Tech',
#                      surname: 'Support',
#                      gender: 'Мужчина',
#                      birthdate: '02.09.1992',
#                      phone1: '+996772180825',
#                      phone2: '+996772180825',
#                      skype: 'skype.tutor',
#                      passportdetails:'MVD 50-01',
#                      email: 'techsupport@gmail.com', password: password, password_confirmation: password)
#
# support.add_role 'techsupport'

element_types = ['Лекция', 'Вебинар', 'Лабараторка', 'Контрольная']  # Types of course elements

student_id = 0 # used to add created students to groups by id
5.times do
  course = Course.create!(name: "#{Faker::Hacker.adjective.capitalize} #{Faker::Hacker.noun.capitalize}")

  10.times do
    CourseElement.create!(
        theme:"#{Faker::Hacker.ingverb.capitalize} #{Faker::Hacker.abbreviation.capitalize}",
        course: course,
        element_type: element_types.sample,
        # content: Faker::Lorem.paragraphs(5).join
    )
  end

  gr_num = 0 # Used for a group title
  2.times do
    gr_num += 1
    group = Group.create!(
        #this takes first letter of each word
        name: "#{course.name.split.map(&:first).join} GR#{gr_num}",
        course: course
    )

    # # Add 5 students to a group
    # 5.times do
    #   #increment student_id to get different student ids
    #   student_id += 1
    #   GroupMembership.create!(
    #       group: group,
    #       user_id: student_id,
    #       active: true)
    # end
    # # Add teacher to a group
    # TeachersGroup.create!(group: group,
    #       user_id: teacher.id,
    #       active: true)
    # # Add support to a group
    # SupportsGroup.create!(group: group,
    #       user_id: support.id,
    #       active: true)

  end
end

# Add Test Student to groups (Course No. 1 and Course No. 2)
# GroupMembership.create!(group_id: 1, user_id: 52, active: true)
# GroupMembership.create!(group_id: 3, user_id: 52, active: true)

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
  count = 0
  10.times do
    t = set_week_day(t)
    c_el_id += 1
    count += 1
    if count <= 3
      study_unit = 1
    elsif count <= 6
      study_unit = 2
    else
      study_unit = 3
    end
    Period.create!(
        title:"Lesson #{c_el_id}",
        group_id: group.id,
        course_id: group.course_id,
        course_element_id: c_el_id,
        commence_datetime: t,
        study_unit_id: study_unit
    )
  end
  t = set_hour(t)

end

########################## end of period seeds ####################
