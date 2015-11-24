class Period < ActiveRecord::Base
  belongs_to :course_element
  has_many :attendances
  has_many :users, through: :attendances
end
