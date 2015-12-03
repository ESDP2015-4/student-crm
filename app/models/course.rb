class Course < ActiveRecord::Base
  has_many :groups
  has_many :course_elements

end
