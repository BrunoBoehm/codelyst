class List < ActiveRecord::Base
	has_many :versions
	has_many :users, through: :versions
end