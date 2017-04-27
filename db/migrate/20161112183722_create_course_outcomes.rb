class CreateCourseOutcomes < ActiveRecord::Migration
  def change
    create_table :course_outcomes do |t|
      t.references :offering, index: true, foreign_key: true
      t.text :outcome
      t.string :rating

      t.timestamps null: false
    end
  end
end
