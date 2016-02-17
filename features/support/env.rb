# IMPORTANT: This file is generated by cucumber-rails - edit at your own peril.
# It is recommended to regenerate this file in the future when you upgrade to a
# newer version of cucumber-rails. Consider adding your own code to a new file
# instead of editing this one. Cucumber will automatically load all features/**/*.rb
# files.

require 'cucumber/rails'

# Capybara defaults to CSS3 selectors rather than XPath.
# If you'd prefer to use XPath, just uncomment this line and adjust any
# selectors in your step definitions to use the XPath syntax.
# Capybara.default_selector = :xpath

# By default, any exception happening in your Rails application will bubble up
# to Cucumber so that your scenario will fail. This is a different from how
# your application behaves in the production environment, where an error page will
# be rendered instead.
#
# Sometimes we want to override this default behaviour and allow Rails to rescue
# exceptions and display an error page (just like when the app is running in production).
# Typical scenarios where you want to do this is when you test your error pages.
# There are two ways to allow Rails to rescue exceptions:
#
# 1) Tag your scenario (or feature) with @allow-rescue
#
# 2) Set the value below to true. Beware that doing this globally is not
# recommended as it will mask a lot of errors for you!
#
ActionController::Base.allow_rescue = false

# Remove/comment out the lines below if your app doesn't have a database.
# For some databases (like MongoDB and CouchDB) you may need to use :truncation instead.
# - Отключил пока DatabaseCleaner
begin
  DatabaseCleaner.strategy = :truncation
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

# You may also want to configure DatabaseCleaner to use different strategies for certain features and scenarios.
# See the DatabaseCleaner documentation for details. Example:
#
#   Before('@no-txn,@selenium,@culerity,@celerity,@javascript') do
#     # { :except => [:widgets] } may not do what you expect here
#     # as Cucumber::Rails::Database.javascript_strategy overrides
#     # this setting.
#     DatabaseCleaner.strategy = :truncation
#   end
#
#   Before('~@no-txn', '~@selenium', '~@culerity', '~@celerity', '~@javascript') do
#     DatabaseCleaner.strategy = :transaction
#   end
#

# Possible values are :truncation and :transaction
# The :transaction strategy is faster, but might give you threading problems.
# See https://github.com/cucumber/cucumber-rails/blob/master/features/choose_javascript_database_strategy.feature
Cucumber::Rails::Database.javascript_strategy = :truncation
Capybara.default_driver = :selenium

Before do
  Role.create!(id: 1, name: 'student')
  Role.create!(id: 2, name: 'manager')
  Role.create!(id: 3, name: 'admin')

  admin = User.create!(id: 1,
                       name: 'Admin',
                       surname: 'Adminovich',
                       gender: 'Мужчина',
                       birthdate: '01.01.1990',
                       phone1: '+996772180825',
                       phone2: '+996772180825',
                       skype: 'skype.admin',
                       passportdetails: 'шнишнашнаппи',
                       email: 'admin@gmail.com',
                       password: 'password',
                       password_confirmation: 'password'
  )
  admin.add_role 'admin'

  student1 = User.create!(id: 2,
                          name: 'Петр',
                          surname: 'Петров',
                          gender: 'Мужчина',
                          birthdate: '01.01.1990',
                          phone1: '+996772654321',
                          phone2: '+996772123456',
                          skype: 'skype',
                          passportdetails: '5001',
                          email: 'student@gmail.com',
                          password: 'password',
                          password_confirmation: 'password',
                          roles: [Role.find_by(name: 'student')]
  )
  student1.add_role 'student'
  student2 = User.create!(id: 3,
                          name: 'Виталий',
                          surname: 'Дятлов',
                          gender: 'Мужчина',
                          birthdate: '01.01.1990',
                          phone1: '+996772111111',
                          phone2: '+996772222222',
                          skype: 'skype.lol',
                          passportdetails: '50-01',
                          email: 'vitaliy@gmail.com',
                          password: 'password',
                          password_confirmation: 'password',
                          roles: [Role.find_by(name: 'student')]
  )
  student2.add_role 'student'
  student3 = User.create!(id: 4,
                          name: 'Владимир',
                          surname: 'Путин',
                          gender: 'Мужчина',
                          birthdate: '01.01.1990',
                          phone1: '+996772111111',
                          phone2: '+996772222222',
                          skype: 'skype.crab',
                          passportdetails: '50-01',
                          email: 'putinka@gmail.com',
                          password: 'password',
                          password_confirmation: 'password',
                          roles: [Role.find_by(name: 'student')]
  )
  student3.add_role 'student'
  student4 = User.create!(id: 5,
                          name: 'Барак',
                          surname: 'Обама',
                          gender: 'Мужчина',
                          birthdate: '01.01.1990',
                          phone1: '+996772111111',
                          phone2: '+996772222222',
                          skype: 'skype.nigga',
                          passportdetails: '50-01',
                          email: 'shokoladka@gmail.com',
                          password: 'password',
                          password_confirmation: 'password',
                          roles: [Role.find_by(name: 'student')]
  )
  student4.add_role 'student'

  Course.create!(id: 1, name: 'Test course')
  # Course.create!(name: 'Second course')
  CourseElement.create!(id: 1, course_id: 1, theme: 'Test Control Work', element_type: 'Контрольная работа')
  Group.create!(id: 1, course_id: 1, name: 'Test group')
  GroupMembership.create!(group_id: 1, user_id: 4, active: true)
  GroupMembership.create!(group_id: 1, user_id: 5, active: true)
end
