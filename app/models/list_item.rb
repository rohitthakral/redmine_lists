class ListItem < ActiveRecord::Base
	belongs_to :project_list
	belongs_to :creator, class_name: 'User', foreign_key: 'created_by'
	belongs_to :updator, class_name: 'User', foreign_key: 'updated_by'
	acts_as_customizable

	def available_custom_fields
		project_list.available_custom_fields
	end
end