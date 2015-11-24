class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :middlename
      t.string :gender
      t.date :birthdate
      t.string :phone1
      t.string :phone2
      t.string :skype
      t.string :passportdetails

      t.timestamps null: false
    end
  end
end
