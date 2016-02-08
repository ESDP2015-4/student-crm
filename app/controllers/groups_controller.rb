class GroupsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    if teacher?
      @groups = current_user.teacher_groups.order(created_at: :desc)
    elsif techsupport?
      @groups = current_user.techsupport_grops.order(created_at: :desc)
    else
      @groups = Group.all.order(created_at: :desc)
    end
  end

  def new
    @group = Group.new
    @groups = Group.all
    @courses = Course.all
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

    @students = @group.students
  end

  def edit
    @group = Group.find(params[:id])
    @courses = Course.all
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
    params.require(:group).permit(:name, :id, :course_id, {:student_ids => []})
  end
end
