class List < ActiveRecord::Base
	has_many :project_lists, :dependent => :delete_all
	has_and_belongs_to_many :custom_fields, :join_table => "#{table_name_prefix}custom_fields_lists#{table_name_suffix}", :foreign_key => "list_id"
end