class CreateTeachersGroups < ActiveRecord::Migration
  def change
    create_table :teachers_groups do |t|
      t.references :user, index: true, foreign_key: true
      t.references :group, index: true, foreign_key: true
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
