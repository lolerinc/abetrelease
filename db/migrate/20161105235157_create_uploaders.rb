class CreateUploaders < ActiveRecord::Migration
  def change
    create_table :uploaders do |t|
      t.references :user
      t.references :file

      t.timestamps null: false
    end
  end
end
