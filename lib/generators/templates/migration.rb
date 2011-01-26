class <%= @name %> < ActiveRecord::Migration
   def self.up
     create_table :<%= @name %> do |t|
        t.string :token
     end
end
