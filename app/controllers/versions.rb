class VersionsController < ApplicationController
	get "/versions" do
		erb :"versions/index.html"
	end
end