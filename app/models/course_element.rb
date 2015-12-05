class CourseElement < ActiveRecord::Base
  belongs_to :course
  has_many :periods

  validates :theme, :presence => true, :length => {:minimum => 1}
  validates :element_type, :presence => true, :length => {:minimum => 1}
  validates :content, :presence => true, :length => {:minimum => 1}
end
