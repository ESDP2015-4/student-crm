class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, index: true
      t.references :resource, :polymorphic => true

      t.timestamps
    end
  end
end
