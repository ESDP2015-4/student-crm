class Attendance < ActiveRecord::Base
  belongs_to :user
  belongs_to :period
end
