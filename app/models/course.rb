class Course < ActiveRecord::Base
  has_many :groups, dependent: :destroy
  has_many :course_elements
  has_many :periods

  validates :name, :presence => true, :length => {:minimum => 1}
end
