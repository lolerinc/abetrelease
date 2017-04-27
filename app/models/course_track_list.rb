class CourseTrackList < ActiveRecord::Base
  belongs_to :track
  belongs_to :course
end
