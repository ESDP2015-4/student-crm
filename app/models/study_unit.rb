class StudyUnit < ActiveRecord::Base

  has_many :periods

  validates :title, presence: true, length: {minimum: 3}
end
