module Sinatra
	module ResourceHelper
		def url_domain(link)
			link.scan(/https?:\/\/[\S]+/i)[0].gsub(/https?:\/\//, "").split('"').first
		end
	end


	helpers ResourceHelper
end