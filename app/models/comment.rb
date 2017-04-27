class Comment < ActiveRecord::Base
	has_one :author
	has_one :user, through: :author
end
