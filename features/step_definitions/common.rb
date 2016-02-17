def login(email)
  visit("/users/sign_in")
  within('#login_form') do
    fill_in 'Эл. почта', :with => email
    fill_in 'Пароль', :with => 'password'
  end
  click_button('Войти')
end

When(/^я захожу на главную страницу$/) do
  visit('/')
end

When(/^я захожу на сайт как "([^"]*)"$/) do |user_email|
  login(user_email)
end

When(/^я захожу в меню "([^"]*)"$/) do |menu|
  page.find(:xpath, ".//*[@id='sidebar-wrapper']/ul/li/a/span[contains(.,'#{menu}')]").click
end

When(/^я вижу надпись "([^"]*)"$/) do |text|
  assert page.has_text?(text)
end

When(/^я вижу кнопку "([^"]*)"$/) do |link_or_button|
  assert page.has_link?(link_or_button)
end

When(/^я не вижу надпись "([^"]*)"$/) do |text|
  assert page.has_no_text?(text)
end

When(/^я не вижу кнопку "([^"]*)"$/) do |link|
  assert page.has_no_link?(link)
end

When(/^я кликаю на "([^"]*)"$/) do |name|
  click_on(name)
end

When(/^я подтверждаю действие в всплывающем окне$/) do
  page.driver.browser.switch_to.alert.accept
end

When(/^выбираю "([^"]*)" из списка "([^"]*)"$/) do |element, list|
  select(element, :from => list)
end

When(/^я ввожу в поле "([^"]*)" значение "([^"]*)"$/) do |field, value|
  fill_in field, with: value
end

When(/^в таблице возле "([^"]*)" я кликаю на "([^"]*)"$/) do |field, link|
  within(:xpath, "//tbody/tr[td/a='#{field}']") do
    click_on(link)
  end
end