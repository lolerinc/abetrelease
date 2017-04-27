class Resource < ActiveRecord::Base
	belongs_to :document
	has_one :uploader
	has_one :user, through: :uploader
end
