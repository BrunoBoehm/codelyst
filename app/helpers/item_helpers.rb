module Sinatra
  module HTMLEscapeHelper
    def h(text)
      Rack::Utils.escape_html(text)
    end
  end

  module Language
  	def lang(item)
  		if item.language
	  	  case item.language.downcase
  	  		when "erb"
  	  			"html"
  	  		when "js"
  	  			"javascript"
  	  		when "html"
  	  			"html"
  	  		when "rb"	
  	  			"ruby"	 			
    		  when "gemfile"
            "ruby"
          when "console"
            "bash"
          when "terminal"
            "bash"
          when "php"
            "php" 
          when "css"
            "css"
          when "scss"
            "css"       
        end
      else   
  			"none"
  		end
  	end
  end


  helpers HTMLEscapeHelper, Language
end