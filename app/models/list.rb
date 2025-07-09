class List < ActiveRecord::Base
	has_many :project_lists, :dependent => :delete_all
	has_and_belongs_to_many :custom_fields, :join_table => "#{table_name_prefix}custom_fields_lists#{table_name_suffix}", :foreign_key => "list_id"

	before_destroy :remove_depedents

	def remove_depedents
		prj_lists = ProjectList.where(list_id: id)
		prj_lists.each do |prj|
			prj_lists.list_item.map(&:destroy)
		end
		prj_lists.map(&:destroy)
	end
end