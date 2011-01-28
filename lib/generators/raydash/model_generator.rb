module Raydash
  module Generators
    class ModelGenerator < Rails::Generator::NamedBase
       def manifest
         record do |m|
           m.migration_template 'migration:migration.rb', "db/migrate", {:assigns => raydash_local_assigns,
             :migration_file_name => 'create_raydash_table_#{custom_file_name}'
           }
         end
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
           assigns[:attributes] = [Rails::Generator::GeneratedAttribute.new("last_squawk", "string")]
           assigns[:attributes] << Rails::Generator::GeneratedAttribute.new("last_squawked_at", "datetime")
         end
       end
    end
  end
end
