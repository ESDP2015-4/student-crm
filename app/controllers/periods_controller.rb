class PeriodsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  # before_action :set_course, only: [:new, :create, :edit, :update]

  def index
    @periods = Period.all
    @period = Period.new
    # @course = @group.course
  end

  def show
    @period = Period.find(params[:id])
  end

  def new
    @period = Period.new
    @group = Group.all
  end

  def create
    @period = Period.new(period_params)

    if @period.save
      redirect_to periods_path(@period.course)
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
      redirect_to periods_path(@period.course)
    else
      render 'edit'
    end
  end

  def destroy
    @period = Period.destroy(params[:id])
    redirect_to root_path
  end

  def calendar_group
    @group = Group.find(params[:group_id])
    @periods = Period.where(group_id: @group.id)
  end

  private

  # def set_course
  #   @course = Course.find(params[:course_id])
  # end

  def period_params
    params.require(:period).permit(
                                   :course_element_id,
                                   :group_id,
                                   :course_id,
                                   :commence_datetime,
                                   :title
    )
  end

end
