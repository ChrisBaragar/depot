class User < ActiveRecord::Base
	attr_accessible :email, :password, :password_confirmation
	after_destroy :ensure_an_admin_remains

	attr_accessor :password
	before_save :encrypt_password

	validates_confirmation_of :password
	validates_presence_of :password, :on => :create
	validates_presence_of :email
	validates_uniqueness_of :email

	def self.authenticate (email,password)
		user = find_by_email(email)
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
			user
		else
			nil
		end
	end

	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end

	private
		
		def ensure_an_admin_remains
			if User.count.zero?
				raise "Cannot delete the last user because no valid account would exist."
			end
		end
end
