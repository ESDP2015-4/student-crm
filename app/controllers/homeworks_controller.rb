class HomeworksController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    if student?
      @homeworks = Homework.where(user: current_user)
    else
      if params[:group_ids]
        @homeworks
      end
      @periods = Period.all
      @passed_periods = @periods.where("commence_datetime < ?", Time.zone.now).sort_by { |period| period.commence_datetime }
    end
  end

  def show
    @passed_periods = @periods.where("commence_datetime < ?", Time.zone.now).sort_by { |period| period.commence_datetime }
    @homework = Homework.find(params[:id])
  end

  def periods
    @periods = Period.all
    @passed_periods = @periods.where("commence_datetime < ?", Time.zone.now).sort_by { |period| period.commence_datetime }
  end

  def period
    @periods = Period.all
    @passed_periods = @periods.where("commence_datetime < ?", Time.zone.now).sort_by { |period| period.commence_datetime }
    @period = Period.find(params[:period_id])
  end

  def new
    if current_user.student_groups.empty?
      redirect_to homeworks_path
      flash[:alert] = 'Вы не записаны ни в одну группу'
    end
    @homework = Homework.new
    @homeworks = Homework.all
    today_date = Time.zone.now.to_json
    student_groups_id = @current_user.student_groups.pluck(:id)
    @actual_periods = Period.find_by_sql("SELECT periods.id, periods.title FROM periods
      left JOIN homeworks on periods.id = homeworks.period_id
      WHERE deadline > #{today_date}
      AND periods.group_id IN (#{student_groups_id.join(', ')})
      AND homeworks.id IS NULL;")
  end

  def create
    Homework.rename_archive
    @homework = Homework.new(homework_params)
    @homework.grade = 1
    @homework.user_id = current_user.id
    if @homework.save
      flash[:success] = 'Домашнее задание загружено'
      redirect_to homeworks_path
    else
      redirect_to new_homework_path
    end
  end

  def edit
    @homework = Homework.find(params[:id])
  end

  def update
    Homework.rename_archive
    @homework = Homework.find(params[:id])
    if @homework.update(homework_params)
      flash[:success] = 'Изменения успешно внесены'
      redirect_to homeworks_path
    else
      render 'update'
    end
  end

  def count_unchecked_homeworks
    @unchecked_homework = Homework.where(grade: 1).length
  end

  private

  def homework_params
    params.require(:homework).permit(:hw_archive, :review, :grade, :period_id)
  end

end
