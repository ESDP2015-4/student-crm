class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.string :title
      t.references :course_element, index: true, foreign_key: true
      t.string :file_id
      t.string :alternate_link
      t.string :permission_id
      t.string :icon_link

      t.timestamps null: false
    end
  end
end
