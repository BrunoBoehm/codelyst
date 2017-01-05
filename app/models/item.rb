class Item < ActiveRecord::Base
	belongs_to :version

	def to_lang
		lang = self.path.split('.')[-1]
		self.language ||= lang
		self.save
	end
end