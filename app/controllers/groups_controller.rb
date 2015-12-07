class GroupsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @groups = Group.all.order(created_at: :desc)
  end

  def new
    @group = Group.new
    @groups = Group.all
    @courses = Course.all
    date_today = Date.today.as_json
    @actual_courses = Course.find_by_sql("SELECT id, name, ends_at FROM courses WHERE ends_at > '#{date_today}'")
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      redirect_to @group
    else
      render 'new'
    end
  end

  def show
    @group = Group.find(params[:id])
    # @course_elements = CourseElement.where(course_id: params[:id])
  end

  def edit
    @group = Group.find(params[:id])
    @date_today = Date.today.as_json
    @end_of_course_date = @group.course.ends_at.as_json
    @courses = Course.all
    @actual_courses = Course.find_by_sql("SELECT id, name, ends_at FROM courses WHERE ends_at > '#{@date_today}'")
  end

  def update
    @group = Group.find(params[:id])

    if @group.update(group_params)
      redirect_to @group
    else
      render 'edit'
    end
  end

  def destroy
    @group = Group.destroy(params[:id])

    redirect_to group_path
  end

  private
  def group_params
    params.require(:group).permit(:name, :course_id)
  end
end
