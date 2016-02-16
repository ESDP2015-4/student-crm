class CoursesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  helper_method :has_periods?

  def index
    if student?
      @courses = current_user.student_courses
    elsif teacher?
      @courses = current_user.teacher_courses
    elsif techsupport?
      @courses = current_user.techsupport_courses
    else
      @courses = Course.all
    end
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to @course
    else
      render 'new'
    end
  end

  def show
    @course = Course.find(params[:id])
    @course_elements = CourseElement.where(course: @course)
    if student?
       @periods = current_user.periods.where(group_id: @course.groups.ids)
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])

    if @course.update(course_params)
      redirect_to @course
    else
      render 'edit'
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    redirect_to courses_path
  end

  def classmates
    @course = Course.find(params[:course_id])
    @classmates = Course.find(params[:course_id]).groups.collect(&:students).flatten.uniq
  end

  def has_periods?(su)
    Course.find(params[:id]).periods.exists?(study_unit: su)
  end

  private
  def course_params
    params.require(:course).permit(:name)
  end
end
