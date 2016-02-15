When(/^я вижу поля Эл\. почта, Пароль и кнопку Войти$/) do
  page.has_xpath?("id('user_email')")
  page.has_xpath?("id('user_password')")
  page.has_xpath?("id('login_form')")
end

When(/^я нахожусь на странице авторизации$/) do
  visit("/users/sign_in")
end

When(/^я ввожу в форму логина значения "([^"]*)" и "([^"]*)"$/) do |email, passwd|
  within('#login_form') do
    fill_in 'Эл. почта', :with => email
    fill_in 'Пароль', :with => passwd
  end
end

When(/^я перехожу на страницу просмотра пользователя$/) do
  page.has_xpath?("id('page-content-wrapper')")
  page.has_css?(".table > tbody:nth-child(1) > tr:nth-child(7) > td:nth-child(2)")
end