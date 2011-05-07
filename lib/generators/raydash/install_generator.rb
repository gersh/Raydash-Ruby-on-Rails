module Raydash
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "This generator install necessary files and configures your application for Raydash. Syntax: 'rails g raydash:install [userid] [secret]'. The userid and secret can be obtained from http://www.raydash.com."
      source_root File.expand_path("../../templates", __FILE__)
      argument :userid, :desc => "Userid from http://www.raydash.com", :required => (ENV['RAYDASH_USERID']==nil), :default => ENV['RAYDASH_USERID']
      argument :secret, :desc => "Secret from http://www.raydash.com", :required => (ENV['RAYDASH_SECRET']==nil), :default => ENV['RAYDASH_SECRET']
      def copy_initializer
        template "raydash.rb", "config/initializers/raydash.rb"
      end
      def show_readme
        readme "README" if behavior == :invoke
      end
    end
  end
end
