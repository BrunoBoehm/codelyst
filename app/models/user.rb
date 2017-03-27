class User < ActiveRecord::Base
	has_many :versions
	has_many :lists, through: :versions
	has_secure_password

	validates :name, :surname, :picture_url, presence: true
	validates :surname, uniqueness: true

	def full_name
		name + " " + surname
	end
end
