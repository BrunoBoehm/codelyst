module Sinatra
  module HTMLEscapeHelper
    def h(text)
      Rack::Utils.escape_html(text)
    end
  end

  module Language
  	def lang(item)
  		if item.language
	  	  case item.language
	  		when "erb"
	  			"html"
	  		when "js"
	  			"javascript"
	  		when "html"
	  			"html"
	  		when "rb"	
	  			"ruby"	
	  		end  			
  		else
  			"none"
  		end

  	end
  end

  helpers HTMLEscapeHelper, Language
end