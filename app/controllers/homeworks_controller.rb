class HomeworksController < ApplicationController
  before_action :authenticate_user!

  load_and_authorize_resource

  def index
    if current_user.has_any_role? :student
      @homeworks = Homework.where("user_id = ?", current_user.id)
    else
      @homeworks = Homework.all
    end
    p params
    p '----------------------'
  end

  def new
    @homework = Homework.new
    @periods = Period.all
    if current_user.groups.empty?
      redirect_to homeworks_path
      flash[:alert] = 'Вы не записаны ни в одну группу'
    else
      today_date = Time.zone.now.beginning_of_day.to_json
      #   @actual_periods = Period.where("deadline > ? AND group_memberships.user_id = ?", today_date, current_user.id)
      @actual_periods = Period.find_by_sql("SELECT
      periods.title,
          groups.name
      FROM periods
      INNER JOIN group_memberships ON periods.group_id = group_memberships.group_id
      INNER JOIN groups ON periods.group_id = groups.id
      WHERE deadline > #{today_date}
      AND group_memberships.user_id = #{current_user.id};")
    end
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
    @actual_periods = Period.where("deadline > ? AND group_id = ?", Time.zone.now.beginning_of_day, current_user.groups.first.id)
    if current_user.has_any_role? :student
      rename_archive()
    end
  end

  def update
    @homework = Homework.find(params[:id])
    if @homework.update(homework_params)
      rename_archive()
      flash[:success] = 'Изменения успешно внесены'
      redirect_to homeworks_path
    else
      render 'update'
    end
  end

  private

  def rename_archive
    name = current_user.name
    surname = current_user.surname
    unless current_user.groups.first.nil?
      group_name = current_user.groups.first[:name].split.join('-')
    end
    hw = @homework.period.title.split.join('-')
    params_array = [name, surname, group_name, hw]
    @homework.hw_archive_file_name = "#{params_array.join('-').downcase! + '.zip'}"
  end

  def homework_params
    params.require(:homework).permit(:hw_archive, :review, :grade, :period_id)
  end

end
