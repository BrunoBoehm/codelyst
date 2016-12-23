class VersionsController < ApplicationController
	get "/versions" do
		@versions = Version.all
		erb :"versions/index.html"
	end
end