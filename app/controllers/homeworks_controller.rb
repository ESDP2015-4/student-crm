class HomeworksController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @homeworks = Homework.all
  end

  def new
    @homework = Homework.new
    @periods = Period.all
  end

  def create
    @homework = Homework.new(homework_params)
    @homework.grade = 1
    rename_archive()
    @homework.user_id = current_user.id
    if @homework.save
      flash[:success] = 'Домашнее задание загружено'
      redirect_to homeworks_path
    else
      render 'new'
    end
  end

  def edit
    @homework = Homework.find(params[:id])
  end

  def replace
    @homework = Homework.find(params[:id])
    rename_archive()
  end

  def update
    @homework = Homework.find(params[:id])
    if current_user.has_any_role? :student
      rename_archive()
    end
    if @homework.update(homework_params)
      flash[:success] = 'Изменения успешно внесены'
      redirect_to homeworks_path
    else
      render 'update'
    end
  end

  def estimate
    @homework = Homework.find(params[:id])
  end

  private

  def rename_archive
    name = current_user.name
    surname = current_user.surname
    unless current_user.groups.first.nil?
      group_name = current_user.groups.first[:name].split.join('-')
    end
    hw = @homework.period.title
    params_array = [name, surname, group_name, hw]
    @homework.hw_archive_file_name = "#{params_array.join('-').downcase! + '.zip'}"
  end

  def homework_params
    params.require(:homework).permit(:hw_archive, :review, :grade, :period_id)
  end

end
