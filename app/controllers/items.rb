class ItemsController < ApplicationController
	get "/items" do
		erb :"items/index.html"
	end
end