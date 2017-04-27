class Degree < ActiveRecord::Base
                    # Cannot delete a degree that is in use
	has_many :tracks, :dependent => :restrict_with_exception

	##############
	# Validation #
	##############

	# Force all uppercase
	before_save { self.name = name.upcase }
	# name must exist and be < 10 characters, and be unique
	validates :name, presence: true, length: { maximum: 50 },
		uniqueness: { case_sensitive: false }
end
