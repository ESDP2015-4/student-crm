class GroupsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @course = Course.find(params[:course_id])
    if teacher?
      @groups = current_user.teacher_groups.order(created_at: :desc)
    elsif techsupport?
      @groups = current_user.techsupport_grops.order(created_at: :desc)
    else
      @groups = @course.groups
    end
  end

  def new
    @group = Group.new
    @course = Course.find(params[:course_id])
  end

  def create
    @course = Course.find(params[:course_id])
    @group = Group.new(group_params)

    if @group.save
      redirect_to course_group_path(@course, @group)
    else
      render 'new'
    end
  end

  def show
    @course = Course.find(params[:course_id])
    @group = Group.find(params[:id])
    @students = @group.students
    @periods = @group.periods
  end

  def edit
    @course = Course.find(params[:course_id])
    @group = Group.find(params[:id])
  end

  def update
    @course = Course.find(params[:course_id])
    @group = Group.find(params[:id])

    if @group.update(group_params)
      redirect_to course_group_path(@course, @group)
    else
      render 'edit'
    end
  end

  def destroy
    @group = Group.destroy(params[:id])

    redirect_to course_group_path
  end

  def change_tab
    @group = Group.find(params[:group_id])
    @students = @group.students
    @periods = @group.periods
    @attendances = Attendance.where(period_id: @periods.ids, user_id: @students.ids)
    case params[:group_tab_id]
      when 'group_students_tab'
        @partial = 'groups/students_list'
      when 'group_periods_tab'
        @partial = 'groups/periods'

      when 'group_attendances_tab'
        @partial = 'groups/attendances'
        @periods= @group.periods
      when 'group_homeworks_tab'
        @partial = 'groups/homeworks'
        @homeworks = @group.students.collect(&:homeworks).flatten.uniq
      else
        @partial = 'groups/students_list'
    end
    respond_to do |format|
      format.js { @partial }
    end


  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def group_params
    params.require(:group).permit(:name, :id, :course_id, {:student_ids => []})
  end
end
