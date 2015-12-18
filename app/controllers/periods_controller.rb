class PeriodsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_course, only: [:new, :create, :edit, :update]

  def index
    @periods = Period.where(course_id: params[:course_id]).order(created_at: :desc)
  end

  def show
    @period = Period.find(params[:id])
  end

  def new
    @period = Period.new
  end

  def create
    @period = Period.new(period_params)

    if @period.save
      redirect_to course_periods_path(@period.course)
    else
      render 'new'
    end
  end

  def edit
    @period = Period.find(params[:id])
  end

  def update
    @period = Period.find(params[:id])

    if @period.update(period_params)
      redirect_to course_periods_path(@period.course)
    else
      render 'edit'
    end
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def period_params
    params.require(:period).permit(:title,
                                   :course_element_id,
                                   :group_id,
                                   :course_id,
                                   :commence_datetime
    )
  end

end
