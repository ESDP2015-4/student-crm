When(/^я нахожусь на главной странице приложения$/) do
  visit("/users/sign_in")
  within('#login_form') do
    fill_in 'Эл. почта', :with => 'manager@gmail.com'
    fill_in 'Пароль', :with => 'password'
  end
  click_button('Войти')
end

When(/^я захожу в меню Пользователи$/) do
  visit('/users')
end

When(/^я вижу надпись Все пользователи и кнопку Добавить пользователя$/) do
  page.has_content?('Все пользователи')
  page.has_css?('#users>.row>.btn')
end

#---------------
#Scenario 2

When(/^я нахожусь на странице просмотра пользователей$/) do
  visit("/users/sign_in")
  fill_in 'Эл. почта', :with => 'manager@gmail.com'
  fill_in 'Пароль', :with => 'password'
  click_button('Войти')
  visit('/users')
end

When(/^нажимаю на кнопку Добавить пользователя$/) do
  click_link('Добавить пользователя')
end

When(/^я перехожу на страницу создания пользователя$/) do
  page.has_css('div.col-md-6:nth-child(1)')
end

When(/^я ввожу в в форму пользователя данные:$/) do |table|
  within('#new_user') do
    fill_in 'Имя', with: table.hashes[0][:имя]
    fill_in 'Фамилия', with: table.hashes[0][:фамилия]
    choose('Мужчина')
    fill_in 'Паспорт', with: table.hashes[0][:паспорт]
    fill_in 'Эл.почта', with: table.hashes[0][:элпочта]
    fill_in 'Тел.1', with: table.hashes[0][:тел1]
  end
end

When(/^нажимаю кнопку "([^"]*)"$/) do |button|
  click_on(button)

end


When(/^вижу введенные ранее данные на странице просмотра пользователя$/) do
  # table is a table.hashes.keys # => [:имя, :фамилия, :паспорт, :элпочта, :тел1]
  page.has_content?('Иванов')
  page.has_content?('Иван')
  page.has_content?('МВД 50-01')
  page.has_content?('ivan@gmail.com')
  page.has_content?('+996555123456')
end