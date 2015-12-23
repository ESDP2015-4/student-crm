When(/^пользователь заходит на ресурс по адресу "([^"]*)"$/) do |link|
  visit(link)
end

When(/^пользователь нажимает кнопку "([^"]*)"$/) do |button|
  click_on(button)
end

When(/^пользователь видит форму авторизации с полями Эл\. почта, Пароль и кнопку Войти$/) do
  page.has_xpath?("id('user_email')")
  page.has_xpath?("id('user_password')")
  page.has_xpath?("id('login_form')")
end
#-------------------
# Scenatio 2

When(/^пользователь находится на странице авторицазии$/) do
  visit("/users/sign_in")
end

When(/^пользователь вводит в форму логина значения "([^"]*)" и "([^"]*)"$/) do |email, passwd|
  fill_in 'Эл. почта', :with => email
  fill_in 'Пароль', :with => passwd
end

When(/^нажимает кнопку "([^"]*)"$/) do |button|
  click_button(button)
end

When(/^пользователь переходит на страницу просмотра пользователя$/) do
  page.has_xpath?("id('page-content-wrapper')")
  page.has_css?(".table > tbody:nth-child(1) > tr:nth-child(7) > td:nth-child(2)")
end