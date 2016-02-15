class AttendancesController < ApplicationController

  def index
    @users = []
    unless params[:group_ids].nil?
      @groups = Group.find(params[:group_ids])
      @groups.each do |group|
        group.students.each do |student|
          @users << student
        end
      end
    end
    #--------------------------
    @periods = periods_filter
    #--------------------------------
    if params[:group_ids]
      @attendances = Attendance.where(period_id: @periods.ids)
    else
      @attendances = []
    end
    #---------------------------------------
    if params[:group_ids]
      @able_periods = @periods.where('commence_datetime < ?', Time.zone.now)
    else
      @able_periods = []
    end
  end


  def periods_filter
    if params[:group_ids]
      @periods = Period.where(:group_id => params[:group_ids])
    else
      @periods = []
    end
  end


  def check
    attendance = Attendance.find(params[:attendance_id])
    if attendance.attended?
      attendance.update(attended: false)
    else
      attendance.update(attended: true)
    end
  end

end

