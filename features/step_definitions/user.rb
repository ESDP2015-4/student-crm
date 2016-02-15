When(/^я ввожу в форму пользователя данные:$/) do |table|
  fill_in 'Имя', with: table.hashes[0][:имя]
  fill_in 'Фамилия', with: table.hashes[0][:фамилия]
  fill_in 'Отчество', with: table.hashes[0][:отчество]
  choose('Мужчина')
  fill_in 'Паспорт', with: table.hashes[0][:паспорт]
  fill_in 'Эл.почта', with: "#{Faker::Name.first_name}.#{Faker::Name.last_name}@gmail.com"
  fill_in 'Тел.1', with: table.hashes[0][:тел1]
end

When(/^вижу введенные ранее данные на странице просмотра пользователя$/) do
  page.has_content?('Иванов')
  page.has_content?('Иван')
  page.has_content?('Иванович')
  page.has_content?('МВД 50-01')
  page.has_content?('ivan@gmail.com')
  page.has_content?('+996555123456')
end

When(/^вижу измененные данные на странице просмотра пользователя$/) do
  page.has_content?('Петров')
  page.has_content?('Петр')
  page.has_content?('Петрович')
  page.has_content?('МВД 50-01')
  page.has_content?('ivan@gmail.com')
  page.has_content?('+996555123456')
end
