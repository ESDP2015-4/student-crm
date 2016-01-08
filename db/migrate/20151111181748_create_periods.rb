class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.references :course_element, index: true, foreign_key: true
      t.datetime :commence_datetime
      t.string :title
      t.timestamps null: false
    end
  end
end
