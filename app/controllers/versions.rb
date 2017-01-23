require 'rack-flash'
class VersionsController < ApplicationController
	# the notion of version should not be part of the the URL when it's the first version
	# then for additional versions we can make allusion to the version element in the URL

	use Rack::Flash

	# index
	get "/versions" do
		@versions = Version.all.order(created_at: :desc)
		erb :"versions/index.html"
	end

	# create a new alternate version out of an existing list
	# should come before the show action - otherwise will interpret params[:id] as new
	get "/lists/:id/versions/new" do
		if logged_in?
			@list = List.find(params[:id])
			erb :"versions/new.html"			
		else
			redirect "/lists"
		end
	end

	# show
	get "/lists/:list_id/versions/:id" do
		@list = List.find(params[:list_id])
		@version = Version.find(params[:id])
		@files = @version.items.order(:path).reject{ |item| item.path.empty? || item.path.downcase == "console" }.uniq{ |file| file.path }
		@items = @version.items.order(:created_at)
		# order will have to be changed when use of jquery sortable, or any other order method
		erb :"versions/show.html"
	end

	### alternative: edit the first version of a list by adding items in bulk
	# get "/lists/:id/create" do
	# 	@list = List.find_by(id: params[:id])
	# 	@version = @list.versions.first
	# 	@items = 10.times.collect{@version.items.build}
	# 	erb :"versions/create.html"
	# end

	### alternative: edit the first version of a list by adding items one at a time
	# action and vanity URL route used only for the first version of a list
	get "/lists/:id/add-items" do
		@list = List.find_by(id: params[:id])
		@version = @list.versions.first
		@items = @version.items
		erb :"versions/add-items.html"
	end

	# create a list (create the first version of the list and nested items)
	# post "/lists/:id" do
	# 	list = List.find(params[:id])
	# 	version = list.versions.first
	# 	params[:version][:item].each do |params|
	# 		version.items.create(params) unless params[:title].empty?
	# 	end
	# 	redirect "/lists/#{list.id}"
	# end

	# create the first item of a list
	post "/list/:id" do
		list = List.find(params[:id])
		version = list.versions.first
		item = version.items.build(params[:item])
		if item.save
			redirect "/lists/#{list.id}"
		else
			erb :"versions/add-items.html"
		end	
	end

	post "/lists/:id/versions/new" do
		# {"version"=>{"title"=>"Second version", "description"=>"Version desc", "user_id"=>"2"}, ...}
		list = List.find(params[:id])
		version = list.versions.build(params[:version])
		if logged_in? && version.save
			redirect to "/lists/#{list.id}/versions/#{version.id}/items/new"
		else
			erb :"versions/new.html"
		end
	end

	# edit a version
	get '/lists/:list_id/versions/:id/edit' do
		@version = Version.find(params[:id])
		owner = @version.user
		if current_user?(owner)
			@list = List.find(params[:list_id])
    		@items = @version.items.all.order(:created_at)
    		erb :"versions/edit.html"
		else
			redirect "/lists"
		end
  	end

  	# update a version
  	patch "/lists/:list_id/versions/:id/edit" do
    	version = Version.find(params[:id]) 
    	owner = version.user
    	if current_user?(owner) && version.update(params[:version])
    		redirect to "/lists/#{params[:list_id]}/versions/#{params[:id]}"
    	else
    		erb :"versions/edit.html"
    	end
  	end

  	# destroy a version
  	delete "/lists/:list_id/versions/:id/delete" do
  		list = List.find(params[:list_id])
  		version = Version.find(params[:id])
  		owner = version.user
  		if current_user?(owner)
	  		version.destroy
	  		list.destroy if list.versions.count == 0
	  		redirect to "/lists"
  		else
  			redirect to "/lists"
  		end
  	end
end