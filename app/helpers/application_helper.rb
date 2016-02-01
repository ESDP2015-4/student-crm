module ApplicationHelper
  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert alert-#{msg_type} fade in alert-dismissible") do
               concat content_tag(:button, 'x', class: "close", data: {dismiss: 'alert'})
               concat message
             end)
    end
    nil
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to title, params.merge(:sort => column, direction: direction, :page => nil)
  end

  def sortable_f(column, title = nil)
    title ||= column.titleize
    direction = column == role_sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to title, params.merge(:sort => column, direction: direction, :page => nil)
  end

  # Используем во вьюшках для проверки на выбранную роль в сессии
  def student?
    session[:current_user_role] == 'student'
  end

  def admin?
    session[:current_user_role] == 'admin'
  end

  def teacher?
    session[:current_user_role] == 'teacher'
  end

  def manager?
    session[:current_user_role] == 'manager'
  end

  def techsupport?
    session[:current_user_role] == 'techsupport'
  end

end
