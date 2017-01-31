class SessionsController < ApplicationController

	get "/snippets" do
		versions = Version.all
		@snippets = versions.map(&:all_code_snippets).flatten.uniq
		erb :"snippets/index.html"
	end

end