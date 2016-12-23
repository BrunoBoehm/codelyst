class Version < ActiveRecord::Base
	belongs_to :list
	belongs_to :user
	has_many :items
end
