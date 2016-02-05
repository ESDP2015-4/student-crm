class CreateStudyUnits < ActiveRecord::Migration
  def change
    create_table :study_units do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
