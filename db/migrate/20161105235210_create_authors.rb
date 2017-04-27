class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.references :user
      t.references :comment

      t.timestamps null: false
    end
  end
end
