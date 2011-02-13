require 'rails/generators'
require 'rails/generators/migration' 

module Raydash
  module Generators
    
    class ModelGenerator < Rails::Generators::NamedBase
      include Rails::Generators::Migration
      desc "Generate a model for working with video tokens"
      source_root File.expand_path("../../templates", __FILE__)
      def manifest
           migration_template 'migration.rb', "db/migrate/create_raydash_table_#{custom_file_name}", {:assigns => raydash_local_assigns(),
             :migration_file_name => 'create_raydash_table_#{custom_file_name}'
           }
      end
      def model
        @custom_name=custom_file_name
	@class_name = class_name.capitalize
        template "model.rb", "app/models/#{custom_file_name}.rb"
      end
      private
       def custom_file_name
	   class_name.underscore.downcase 
       end
       def custom_name
           custom_name = class_name.underscore.downcase
           custom_name = custom_name.pluralize if ActiveRecord::Base.pluralize_table_names
       end
       def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          Time.now.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end
      def raydash_local_assigns
        returning(assigns = {}) do
          assigns[:migration_action] = "add"
          assigns[:class_name] = "add_raydash_table_#{custom_file_name}"
          assigns[:table_name] = custom_file_name
          assigns[:attributes] = [Rails::Generators::GeneratedAttribute.new("token", "string")]
          assigns[:attributes] << Rails::Generators::GeneratedAttribute.new("connected_to","string")
        end
      end
    end
  end
end
