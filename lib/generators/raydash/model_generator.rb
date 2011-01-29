require 'migration' 

module Raydash
  module Generators
    
    class ModelGenerator < Rails::Generators::NamedBase
      desc "Generate a model for working with video tokens"
      source_root File.expand_path("../../templates", __FILE__)
      def manifest
         #record do |m|
           migration_template 'migration:migration.rb', "db/migrate", {:assigns => raydash_local_assigns,
             :migration_file_name => 'create_raydash_table_#{custom_name}'
           }
         #end
      end
      def model
        @custom_name=custom_file_name
        template "model.rb", "app/models/#{custom_file_name}.rb"
      end
      private
      def custom_file_name
        custom_name = class_name.underscore.downcase
        custom_name = custom_name.pluralize if ActiveRecord::Base.pluralize_table_names
      end

      def raydash_local_assigns
        returning(assigns = {}) do
          assigns[:migration_action] = "add"
          assigns[:class_name] = "add_raydash_table_#{custom_file_name}"
          assigns[:table_name] = custom_file_name
          assigns[:attributes] = [Rails::Generator::GeneratedAttribute.new("token", "string")]
          assigns[:attributes] << Rails::Generator::GeneratedAttribute.new("connected_to","string")
        end
      end
    end
  end
end
