class Period < ActiveRecord::Base
  belongs_to :course_element
  belongs_to :group
  belongs_to :course
  has_many :attendances
  has_many :users, through: :attendances
  has_many :homework

  validates :course_id, presence: true
end
