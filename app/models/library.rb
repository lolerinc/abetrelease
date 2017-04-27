class Library < ActiveRecord::Base
  belongs_to :offering
  belongs_to :document
end
