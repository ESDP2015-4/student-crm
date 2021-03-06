#language: ru

Функционал: сценарии тестирования добавления, редактирования,
  удаления занятий и раздаточных материалов

  Сценарий: добавление занятия для курса
    Допустим я захожу на сайт как "admin@gmail.com"
    И я кликаю на "Test course"
    Если я кликаю на "Добавить занятие"
    И выбираю "Контрольная работа" из списка "Тип элемента"
    И я ввожу в поле "Тема" значение "Первая контрольная работа"
    И я кликаю на "Сохранить"
    То я вижу надпись "Занятие: Контрольная работа"
    И я вижу надпись "Тема: Первая контрольная работа"
    И я вижу кнопку "Добавить раздаточный материал"

  Сценарий: редактирование занятия для курса
    Допустим я захожу на сайт как "admin@gmail.com"
    И я кликаю на "Test course"
    Если я кликаю на "Редактировать"
    И выбираю "Лекция" из списка "Тип элемента"
    И я ввожу в поле "Тема" значение "Первая лекция"
    И я кликаю на "Сохранить"
    То я вижу надпись "Лекция"
    И я вижу кнопку "Первая лекция"

#  Сценарий: удаление занятия для курса
#    Допустим я захожу на сайт как "admin@gmail.com"
#    И я кликаю на "Test course"
#    Если я кликаю на "Удалить"
#    И я подтверждаю действие в всплывающем окне
#    То я не вижу надпись "Контрольная работа"
#    И я не вижу кнопку "Test Control Work"

  Сценарий: добавление раздаточного материала для занятия