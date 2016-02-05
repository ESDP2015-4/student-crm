class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include ApplicationHelper

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { render nothing: true, status: :forbidden }
      format.html { redirect_to main_app.root_url, :alert => exception.message }
    end
  end

  def after_sign_in_path_for(resource)
    set_default_role
    user_path(current_user)
  end
  before_filter :set_current_user

  def set_current_user
    User.current_user = current_user
  end

  # Выбираем роль по умолчанию при логине. Роль с большими полномочиями имеет больший вес
  def set_default_role
    if current_user.has_any_role? :admin
      choose_role(:admin)
    elsif current_user.has_any_role? :manager
      choose_role(:manager)
    elsif current_user.has_any_role? :teacher
      choose_role(:teacher)
    elsif current_user.has_any_role? :techsupport
      choose_role(:techsupport)
    else
      choose_role(:student)
    end
  end

  # Пользователь выбирает роль, под которой будет работать в системе
  def choose_role(role)
    session[:current_user_role] = role
  end
end
