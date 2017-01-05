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
	  			"ruby"
	  		when "js"
	  			"javascript"
	  		when "html"
	  			"html"
	  		when "rb"	
	  			"ruby"	
	  		end  			
  		else
  			"html"
  		end

  	end
  end

  helpers HTMLEscapeHelper, Language
end