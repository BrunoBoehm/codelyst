ENV['SINATRA_ENV'] ||= "development"

require "bundler/setup"
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

Dir[File.join(File.dirname(__FILE__), "../app/helpers", "*.rb")].sort.each {|f| require f}
# load the helpers first
Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), "../app/controllers", "*.rb")].sort.each {|f| require f}