class User < ActiveRecord::Base

	# relationships
	has_many :acts, dependent: :destroy
	has_many :activities, through: :acts

	# filters
	before_save { self.email = email.downcase }
	before_create :create_remember_token

	# validations
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
			uniqueness: { case_insensitive: false }
	has_secure_password
	validates :password, length: { minimum: 6 }

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def feed
		# This is preliminary. See "following users" for the full implementation
		Act.where("user_id = ?", id)
	end

	private

		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end
end
