class Group < ActiveRecord::Base
  belongs_to :course
  has_many :periods
  has_many :group_memberships
  has_many :students, through: :group_memberships, source: :student #this one works
  has_many :teachers, through: :teachers_groups, source: :teacher #this one also works
  has_many :techsupports, through: :supports_groups, source: :techsupport

  # def students
  #   GroupMembership.where("group_id = #{id} AND student_id is not null").distinct
  # end
  #
  # def teachers
  #   GroupMembership.where("group_id = #{id} AND teacher_id is not null").distinct
  # end


  validates :name, presence: true
end
