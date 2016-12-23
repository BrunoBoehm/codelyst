class User < ActiveRecord::Base
	has_many :versions
	has_many :lists, through: :versions
end
