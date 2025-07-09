class ProjectList < ActiveRecord::Base
	belongs_to :list
	belongs_to :project
	# acts_as_customizable
	has_many :list_items, :dependent => :delete_all

	def available_custom_fields
		list.custom_fields.to_a
	end

end