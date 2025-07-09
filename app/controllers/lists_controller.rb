class ListsController < ApplicationController
	layout 'admin'
  	before_action :require_admin

	def index
		@lists = List.all
	end

	def new
		@list = List.new
	end

	def update
		list = List.find_by_id(params[:id])
		list.update(permit_param)
		flash[:notice] = "Successfully updated"
		redirect_to lists_path
	end

	def create
		list = List.new(permit_param)
		if list.save
			recreate_project_menu(list)
			flash[:notice] = "Successfully added"
			redirect_to lists_path
		else
			flash[:error] = list.errors.full_messages
			redirect_to lists_path
		end
	end

	def edit
		@list = List.find params[:id]
	end

	def destroy
		@list = List.find params[:id]
		@list.destroy
		rebuild_project_menu(@list)
		flash[:notice] = "Successfully deleted"
		redirect_to lists_path
	end

	def show
		@list = List.find params[:id]
		@fields = @list.custom_fields
	end

	def custom_field
		@list = List.find params[:list_id]
		CustomFieldsList.where(list_id: @list.id).delete_all
		params[:custom_fields].each do |cf|
			CustomFieldsList.create(list_id: @list.id, custom_field_id: cf)
		end
		flash[:notice] = "Successfully updated"
		redirect_to list_path(@list)
	end

	private

	def rebuild_project_menu(list)
		Redmine::MenuManager.map :project_menu do |menu|
		    menu.delete(list.name.underscore.to_sym)
		end
	end

	def recreate_project_menu(list)
		Redmine::MenuManager.map :project_menu do |menu|
		    menu.push list.name.underscore.to_sym, {:controller => 'projects_lists', :action => 'index', list_id: list.id},:after => :issues, :param => :project_id, caption: "#{list.name}",
              :if => Proc.new { |p| ProjectList.where(project_id: p.id, list_id: list.id).present? && User.current.allowed_to?(:manage_lists, p)},
              html: {class: 'list_items_project_menu'}
		end
	end

	def permit_param
		params.require(:list).permit(:name, :description, :global)
	end
end