class CourseElementsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def new
    @course_element = CourseElement.new
  end

  def create
    @course_element = CourseElement.new(course_element_params)
    if @course_element.save
      redirect_to course_path(@course_element.course)
    else
      render 'new'
    end
  end

  def edit
    @course_element = CourseElement.find(params[:id])
  end

  def update
    @course_element = CourseElement.find(params[:id])
    if @course_element.update(course_element_params)
       redirect_to course_path(@course_element.course)
    else
      render 'new'
    end
  end

  private

  def course_element_params
    params.require(:course_element).permit(:theme, :element_type, :content, :course_id)
  end
end
