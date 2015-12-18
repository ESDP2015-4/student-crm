class Group < ActiveRecord::Base
  belongs_to :course
  has_many :periods
  has_many :group_memberships
  has_many :students, through: :group_memberships, source: :user

  validates :name, presence: true
end
