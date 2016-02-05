class GroupMembership < ActiveRecord::Base
  belongs_to :group
  belongs_to :student, class_name: "User"
end
