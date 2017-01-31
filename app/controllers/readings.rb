class ReadingsController < ApplicationController

	get "/readings" do
		versions = Version.all
		@readings = versions.map(&:all_links).flatten.uniq
		erb :"readings/index.html"
	end

end