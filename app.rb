# Note: the name of this file (app.rb) is irrelevant.

# Require config/environment.rb
require ::File.expand_path('../config/environment',  __FILE__)

set :app_file, __FILE__

post '/scenes' do
  # create a new scene
  Scene.create(:parent_id => params[:parent_id], :title => params[:title], :body => params[:body])
  # How? Did this work?
  redirect to('/')
end

get '/' do
  scenes = Scene.order(:created_at)
  erb :index, :locals => {:scenes => scenes}
end

post "/scenes/:id/delete" do
  scene = Scene.where(:id => params[:id])
  scene.delete
  redirect to('/')
end