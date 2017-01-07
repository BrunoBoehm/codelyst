ENV['SINATRA_ENV'] ||= "development"

require "bundler/setup"
Bundler.require(:default, ENV['SINATRA_ENV'])

configure :development do
	ActiveRecord::Base.establish_connection(
	  :adapter => "sqlite3",
	  :database => "db/development.sqlite"
	)	
end

configure :production do
	db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/production')

	ActiveRecord::Base.establish_connection(
	:adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
	:host     => db.host,
	:username => db.user,
	:password => db.password,
	:database => db.path[1..-1],
	:encoding => 'utf8'
	)	
end

Dir[File.join(File.dirname(__FILE__), "../app/helpers", "*.rb")].sort.each {|f| require f}
# load the helpers first
Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), "../app/controllers", "*.rb")].sort.each {|f| require f}