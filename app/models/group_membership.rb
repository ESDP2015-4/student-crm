class GroupMembership < ActiveRecord::Base
  belongs_to :group
  belongs_to :student, class_name: "User", foreign_key: 'user_id'

  after_save :create_attendances
  # Will create attendances if a user is added to a group
  def create_attendances
    self.group.periods.each do |period|
      Attendance.create!(period: period, user: self.student)
    end
  end
end
