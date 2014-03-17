# Automatically set created_at/updated_at timestamps
Sequel::Model.plugin :timestamps, :update_on_create => true

# Automatically load every file in APP_ROOT/models/*.rb, e.g.,
#   autoload "Person", 'models/person.rb'
#
# See http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html
#
Dir[APP_ROOT.join('models', '*.rb')].each do |model_file|
  filename = File.basename(model_file).gsub('.rb', '')
  autoload ActiveSupport::Inflector.camelize(filename), model_file
end

# We have to do this in case we have models that inherit from each other.
# If model Student inherits from model Person and models/student.rb is
# required first, it will throw an error saying "Person" is undefined.
#
# With this lazy-loading technique, Ruby will try to load models/person.rb
# the first time it sees "Person" and will only throw an exception if
# that file doesn't define the Person class.

# Heroku controls what database we connect to by setting the DATABASE_URL environment variable
# We need to respect that if we want our Sinatra apps to run on Heroku without modification

default_db_name = "#{APP_NAME}_#{Sinatra::Application.environment}.sqlite3"

ENV['DATABASE_URL'] ||= "sqlite://#{APP_ROOT.join('db', default_db_name)}"

# Note:
#   Sinatra::Application.environment is set to the value of ENV['RACK_ENV']
#   if ENV['RACK_ENV'] is set.  If ENV['RACK_ENV'] is not set, it defaults
#   to :development

options = case Sinatra::Application.environment
          when :development
            {:logger => Logger.new(STDOUT)}
          else
            {}
          end

DB = Sequel.connect(ENV['DATABASE_URL'], options)
