class TeachersGroup < ActiveRecord::Base
  belongs_to :group
  belongs_to :teacher, class_name: "User", foreign_key: 'user_id'
end
