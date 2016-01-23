class AddPeriodToHomeworks < ActiveRecord::Migration
  def change
    add_reference :homeworks, :period, index: true, foreign_key: true
  end
end
