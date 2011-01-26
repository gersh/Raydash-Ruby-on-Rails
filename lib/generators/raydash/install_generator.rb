module Raydash
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      mattr :userid
      mattr :secret
      def copy_initializer
        template "raydash.rb", "config/initializers/raydash.rb"
      end
      def copy_flash
        empty_directory "public/swfs"
        copy_file "StreamBox.swf", "public/swfs/raydashstream.swf"
        copy_file "RecordBox.swf", "public/swf/raydashrecord.swf"
      end
      def copy_flash_javascript
        copy_file "swfobject.js", "public/javascripts/swfobject.js"
      en
      def show_readme
        readme "README" if behavior == :invoke
      end
    end
  end
end
