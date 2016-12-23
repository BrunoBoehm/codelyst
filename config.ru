require_relative "./config/environment.rb"

if defined?(ActiveRecord::Migrator) && ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride

use UsersController
use SessionsController
use ItemsController
use ListsController
use VersionsController
run ApplicationController