module Sinatra
	module ResourceHelper
		def url_domain(link)
			link.scan(/https?:\/\/[\S]+/i).first.gsub(/https?:\/\//, "").split('"').first
			
		end

		def full_url(link)
			link.scan(/https?:\/\/[\S]+/i)[0].gsub(/https?:\/\//, "").split('"').first
		end
	end


	helpers ResourceHelper
end