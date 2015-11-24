class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.references :user, index: true, foreign_key: true
      t.references :period, index: true, foreign_key: true
      t.boolean :attended

      t.timestamps null: false
    end
  end
end
