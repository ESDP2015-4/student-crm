class AddDeadlineToPeriods < ActiveRecord::Migration
  def change
    add_column :periods, :deadline, :datetime
  end
end
