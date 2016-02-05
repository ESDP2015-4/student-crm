class CreateSupportsGroups < ActiveRecord::Migration
  def change
    create_table :supports_groups do |t|
      t.references :user, index: true, foreign_key: true
      t.boolean :active, default: true
      t.references :group, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
