class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :code_suffix
      t.string :code_prefix

      t.timestamps null: false
    end
  end
end
