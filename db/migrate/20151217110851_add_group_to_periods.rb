class AddGroupToPeriods < ActiveRecord::Migration
  def change
    add_reference :periods, :group, index: true, foreign_key: true
  end
end
