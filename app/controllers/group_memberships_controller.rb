class GroupMembershipsController < ApplicationController
  load_and_authorize_resource :group
  load_and_authorize_resource :group_membership, through: :group
  def new
    @course = Course.find(params[:course_id])
    @gm = GroupMembership.new
    @group = Group.find(params[:group_id])
    scoped_users = User.all
    @users = User.search(params[:search], scoped_users)
  end

  def create
    @gm = GroupMembership.new(group_membership_params)
    params[:group_membership][:user_id].each do |student_id|
      GroupMembership.create!(group_id: params[:group_id], user_id: student_id)
    end
    redirect_to course_group_path(params[:course_id],params[:group_id])
  end

  private

  def group_membership_params
    params.require(:group_membership).permit(:user_ids, :group_id, :course_id)
  end

end
