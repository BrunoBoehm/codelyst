class User < ActiveRecord::Base
	has_many :versions
	has_many :lists, through: :versions
	has_secure_password

	def full_name
		name + " " + surname
	end
end
