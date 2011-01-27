module Raydash
  module Generators
    class ModelGenerator < Rails::Generator::NamedBase
      include Rails::Generators::Migration
      class_option :class_name
      # Implement the required interface for Rails::Generators::Migration.
      # taken from http://github.com/rails/rails/blob/master/activerecord/lib/generators/active_record.rb
      def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations then
          Time.now.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end

      def create_migration_file
	@name=option[:class_name]
        migration_template 'migration.rb', 'db/migrate/create_raydash_table.rb'
      end
    end
  end
end
