class SupportsGroup < ActiveRecord::Base
  belongs_to :group
  belongs_to :techsupport, class_name:"User"
end
