class ListsController < ApplicationController

	get "/lists" do
		erb :"lists/index.html"
	end
end