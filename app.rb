# Note: the name of this file (app.rb) is irrelevant.

# Require config/environment.rb
require ::File.expand_path('../config/environment',  __FILE__)

set :app_file, __FILE__

post '/scenes' do
  # create a new scene
end

get '/' do
  erb :index
end

