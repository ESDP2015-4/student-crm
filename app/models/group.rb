class Group < ActiveRecord::Base
  belongs_to :course
  has_many :periods
  has_many :group_memberships
  has_many :teachers_groups
  has_many :supports_groups
  has_many :students,     through: :group_memberships,  source: :student #this one works
  has_many :teachers,     through: :teachers_groups,    source: :teacher
  has_many :techsupports, through: :supports_groups,    source: :techsupport

  validates :name, presence: true
end
