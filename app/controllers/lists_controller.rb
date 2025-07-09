class ListsController < ApplicationController
	layout 'admin'
  	before_action :require_admin

	def index
		@lists = List.all
	end

	def new
		@list = List.new
	end

	def create
		list = List.new(permit_param)
		if list.save
			flash[:notice] = "Successfully added"
			redirect_to lists_path
		else
			flash[:error] = list.errors.full_messages
			redirect_to lists_path
		end
	end

	def show
		@list = List.find params[:id]
		@fields = @list.custom_fields
	end

	def custom_field
		
	end

	private

	def permit_param
		params.require(:list).permit(:name, :description, :global)
	end
end