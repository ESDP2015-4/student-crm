#xpath that finds links in sidebar by name
# .//*[@id='sidebar-wrapper']/ul/li/a/span[contains(.,'Группы')]

When(/^я кликаю на "([^"]*)" возле названия курса Test course$/) do |edit|
  within(:xpath, "//tbody/tr[td/a='Test course']") do
    click_on(edit)
  end
end