class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :fname
      t.string :lname
      t.string :email
      t.string :permission

      t.timestamps null: false
    end
  end
end
