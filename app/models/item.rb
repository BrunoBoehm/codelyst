class Item < ActiveRecord::Base
	belongs_to :version
	validates :title, presence: true

	def to_lang
		code_lang = self.path.split('.')[-1]
		self.language = code_lang || self.language
		self
	end
end