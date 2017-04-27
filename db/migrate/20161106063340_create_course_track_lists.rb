class CreateCourseTrackLists < ActiveRecord::Migration
  def change
    create_table :course_track_lists do |t|
      t.references :track, index: true, foreign_key: true
      t.references :course, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
