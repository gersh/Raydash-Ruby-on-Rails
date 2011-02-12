class <%= @name %> < ActiveRecord::Migration
   def self.up
     create_table :<%= @name %> do |t|
        t.string :token
	t.string :connected_to
     end
   end
   def self.down
     drop_table :<%= @name %>
   end
end
