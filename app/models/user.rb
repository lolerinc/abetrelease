class User < ActiveRecord::Base
	has_many :teachings, :dependent => :restrict_with_exception
	has_many :offerings, :through => :teachings, :dependent => :restrict_with_exception
	has_many :approvers, :dependent => :restrict_with_exception
	has_many :tracks, :through => :approvers, :dependent => :restrict_with_exception
	has_many :authors
	has_many :comments, :through => :authors
	has_many :uploaders
	has_many :resources, :through => :uploaders

	# Force a lower-case email
  before_save { self.email = email.downcase }
	# Username must exist and be < 50 characters
	validates :name, presence: true, length: { maximum: 50 }
	# Email must make sense
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
	  format: { with: VALID_EMAIL_REGEX },
		uniqueness: { case_sensitive: false }
	has_secure_password
	# Password must exist with minimum of 8 characters
	#validates :password, presence: true, length: { minimum: 8 }
	validates :password, presence: true, 
		if: Proc.new { |user| user.password.present? }, confirmation: true, on: :update
end
