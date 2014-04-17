# Note: the name of this file (app.rb) is irrelevant.

# Require config/environment.rb
require ::File.expand_path('../config/environment',  __FILE__)

set :app_file, __FILE__

get '/' do
  first_scene = Scene.first_scene

  if first_scene
    redirect to("/scenes/#{first_scene.id}")
  else
    redirect to('/scenes')
  end
end

get '/scenes/:id' do
  scene = Scene.where(:id => params[:id]).first
  erb :scene, :locals => {:scene => scene}
end

get '/scenes' do
  scenes = Scene.order(:created_at)
  erb :scenes, :locals => {:scenes => scenes}
end

post '/scenes' do
  Scene.create(:parent_id => params[:parent_id], :title => params[:title],
                :body => params[:body],:timer_enabled => params[:timer_enabled] || false)
  redirect to('/scenes')
end

post "/scenes/:id/delete" do
  scene = Scene.where(:id => params[:id])
  scene.delete
  redirect to('/scenes')
end
