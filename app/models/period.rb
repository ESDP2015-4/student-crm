class Period < ActiveRecord::Base
  belongs_to :course_element
  belongs_to :group
  belongs_to :course
  has_many :attendances
  has_many :users, through: :attendances
  has_many :homework

  validates :course_id, presence: true
  validates :group_id, presence: true
  validates :title, presence: true, length: {minimum: 5}

  after_save :create_attendances
  # Если сохранили новое занятие, то необходимо создать для этого занятие посещаемость для студентов:
  def create_attendances
    self.group.students.each do |student|
      Attendance.create!(user_id: student.id, period_id: self.id)
    end
  end
end
