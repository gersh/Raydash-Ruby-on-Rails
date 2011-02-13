class <%= @class_name %> < ActiveRecord::Migration
   def self.up
     create_table :<%= @custom_name %> do |t|
        t.string :token
	t.string :connected_to
     end
   end
   def self.down
     drop_table :<%= @custom_name %>
   end
end
