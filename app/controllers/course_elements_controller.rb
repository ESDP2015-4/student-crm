class CourseElementsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_course, only: [:new, :create, :edit, :update]

  def destroy_reading
    @reading = Reading.destroy(params[:id])
    redirect_to course_course_element_path(@reading.course_element.course, @reading.course_element)
  end

  def new
    @course_element = CourseElement.new
  end

  def show
    @course_element = CourseElement.find(params[:id])
  end

  def create
    @course.course_elements.build(course_element_params)

    if @course_element.save
      redirect_to course_course_element_path(@course, @course_element)
    else
      render 'new'
    end
  end

  def edit
    @course_element = CourseElement.find(params[:id])
  end

  def destroy
    @course_element = CourseElement.find(params[:id])
    @course_element.destroy

    redirect_to :back
  end

  def update
    @course_element = CourseElement.find(params[:id])
    if @course_element.update(course_element_params)
       redirect_to course_path(@course_element.course)
    else
      render 'edit'
    end
  end

  def new_readings
    @course_element = CourseElement.find(params[:id])

    @client = Google::APIClient.new
    @client.authorization.access_token = Token.last.fresh_token
    @drive_api = @client.discovered_api('drive', 'v2')

    @results = @client.execute!(
        :api_method => @drive_api.files.list)
    @reading = Reading.new
  end

  def create_readings
    @reading = Reading.create!(reading_params)

    if @reading.save
      redirect_to course_elements_new_readings_path(@reading.course_element)
      flash[:notice] = "Added"
    else
      flash[:alert] = "You couldn't add"
    end
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def course_element_params
    params.require(:course_element).permit(:theme, :element_type, :course_id)
  end

  def reading_params
    params.require(:reading).permit(:course_element_id, :file_id, :alternate_link, :permission_id, :title, :icon_link)
  end

end
