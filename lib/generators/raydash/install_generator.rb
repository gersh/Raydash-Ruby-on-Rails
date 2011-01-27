module Raydash
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      class_option :userid, :desc => "Userid from http://www.raydash.com"
      class_option :secret, :desc => "Secret from http://www.raydash.com"
      def copy_initializer
        @userid=options[:userid]
        @secret=options[:secret]
        template "raydash.rb", "config/initializers/raydash.rb"
      end
      def copy_flash
        empty_directory "public/swfs"
        copy_file "StreamBox.swf", "public/swfs/raydashstream.swf"
        copy_file "RecordBox.swf", "public/swf/raydashrecord.swf"
      end
      def copy_flash_javascript
        copy_file "swfobject.js", "public/javascripts/swfobject.js"
      end
      def show_readme
        readme "README" if behavior == :invoke
      end
    end
  end
end
