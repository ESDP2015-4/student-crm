class AddStudyUnitToPeriods < ActiveRecord::Migration
  def change
    add_reference :periods, :study_unit, index: true, foreign_key: true
  end
end
