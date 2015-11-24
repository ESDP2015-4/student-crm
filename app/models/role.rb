class Role < ActiveRecord::Base
  validates :rolename, presence: true

  has_and_belongs_to_many :users
end
