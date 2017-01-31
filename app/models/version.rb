class Version < ActiveRecord::Base
	belongs_to :list
	belongs_to :user
	has_many :items, dependent: :destroy

	def all_code_snippets
		self.items.map(&:description).join.scan(/<code>(.+?)<\/code>/i).uniq.flatten
	end

	def all_links
		self.items.map(&:description).join.scan(/(?=(<a))(.+?)(?<=(a>))/i).uniq.map{|x| x[1]}
		# self.items.map(&:description).join.scan(/https?:\/\/[\S]+\\/i).uniq.flatten
	end
end
