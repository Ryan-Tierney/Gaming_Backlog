require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end



use Rack::MethodOverride #Sinatra Middleware - allows for use of patch and delete methods, and must be placed above all other controllers
use UsersController
run ApplicationController