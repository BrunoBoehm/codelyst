class Version < ActiveRecord::Base
	belongs_to :list
	has_many :items
end
