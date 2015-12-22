class GroupMembershipsController < ApplicationController

  def new
    @gm = GroupMembership.new
    @group = Group.find(params[:group_id])
    @users = User.search(params[:search])
  end

  def create
    params[:group_membership][:user_id].each do |student_id|
      GroupMembership.create!(group_id: params[:group_id], user_id: student_id)
    end

    redirect_to group_path(params[:group_id])
  end


end