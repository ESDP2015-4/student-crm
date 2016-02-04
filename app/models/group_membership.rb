class GroupMembership < ActiveRecord::Base
  belongs_to :group
  belongs_to :student, class_name: "User"


  before_save :default_status

  private

  def default_status
    if self.new_record?
      self.active = true
    end
  end
end
