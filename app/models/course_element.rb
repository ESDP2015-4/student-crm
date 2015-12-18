class CourseElement < ActiveRecord::Base
  belongs_to :course
  has_many :periods
  has_many :readings

  validates :theme, :presence => true, :length => {:minimum => 1}
  validates :element_type, :presence => true, :length => {:minimum => 1}
end
