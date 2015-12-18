class AddCourseToPeriods < ActiveRecord::Migration
  def change
    add_reference :periods, :course, index: true, foreign_key: true
  end
end
