require 'rake'

require ::File.expand_path('../config/environment', __FILE__)

# Include all of ActiveSupport's core class extensions, e.g., String#camelize
require 'active_support/core_ext'

namespace :generate do
  desc "Create an empty model in app/models, e.g., rake generate:model NAME=User"
  task :model do
    unless ENV.has_key?('NAME')
      raise "Must specificy model name, e.g., rake generate:model NAME=User"
    end

    model_name     = ENV['NAME'].camelize
    model_filename = ENV['NAME'].underscore + '.rb'
    model_path = APP_ROOT.join('models', model_filename)

    if File.exist?(model_path)
      raise "ERROR: Model file '#{model_path}' already exists"
    end

    puts "Creating #{model_path}"
    File.open(model_path, 'w+') do |f|
      f.write(<<-EOF.strip_heredoc)
        class #{model_name} < Sequel::Model(:#{model_name.pluralize.underscore})
          # Remember to create a migration!
          # rake generate:migration NAME=create_#{model_name.pluralize.underscore}
        end
      EOF
    end

    puts ""
    puts "** Remember to create a migration if necessary!"
    puts "** e.g., rake generate:migration NAME=create_#{model_name.pluralize.underscore}"
  end

  desc "Create an empty migration in db/migrate, e.g., rake generate:migration NAME=create_tasks"
  task :migration do
    unless ENV.has_key?('NAME')
      raise "Must specificy migration name, e.g., rake generate:migration NAME=create_tasks"
    end

    name     = ENV['NAME'].camelize
    filename = "%s_%s.rb" % [Time.now.strftime('%Y%m%d%H%M%S'), ENV['NAME'].underscore]
    path     = APP_ROOT.join('db', 'migrate', filename)

    if File.exist?(path)
      raise "ERROR: File '#{path}' already exists"
    end

    puts "Creating #{path}"
    File.open(path, 'w+') do |f|
      f.write(<<-EOF.strip_heredoc)
        # See http://sequel.jeremyevans.net/rdoc/files/doc/migration_rdoc.html
        Sequel.migration do
          change do
            # The changes we want to make to our database, e.g.,
            # adding a new string column to the posts table called "url"
            #
            # add_column :posts, :url, :string
          end
        end
      EOF
    end
  end
end

namespace :db do
  desc "Drop, create, and migrate the database"
  task :reset => [:drop, :migrate]

  desc "Drop the current database"
  task :drop do
    db_name = APP_ROOT.join('db', "#{APP_NAME}_development.sqlite3")
    puts "Dropping database #{File.basename(db_name)}"
    system("rm -f '#{db_name}'")
  end

  desc "Migrate the database (options: VERSION=x)."
  task :migrate do
    require "sequel"

    Sequel.extension :migration

    db = Sequel.connect(ENV.fetch("DATABASE_URL"))
    migrations_dir = APP_ROOT.join('db', 'migrate');

    if ENV['VERSION']
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, migrations_dir, :target => ENV['VERSION'])
    else
      puts "Migrating to latest version"
      Sequel::Migrator.run(db, migrations_dir)
    end
  end
end

desc 'Start IRB with application environment loaded'
task "console" do
  exec "irb -r./config/environment"
end
