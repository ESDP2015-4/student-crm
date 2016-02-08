class AttendancesController < ApplicationController
  def index
    @group = Group.find 1
    @students = @group.students
    @periods = Period.where(group_id: @group.id)
    @attendances = Attendance.where(period_id: @periods.ids, user_id: @students.ids)
  end

  def mark
    a = Attendance.find(params[:attendance_id])
    if a.attended?
      a.update(attended: false)
    else
      a.update(attended: true)
    end
  end
end
