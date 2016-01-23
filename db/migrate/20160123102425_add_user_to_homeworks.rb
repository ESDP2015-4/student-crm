class AddUserToHomeworks < ActiveRecord::Migration
  def change
    add_reference :homeworks, :user, index: true, foreign_key: true
  end
end
