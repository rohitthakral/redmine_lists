class ProjectsListsController < ApplicationController
	include CustomFieldsHelper
	helper :custom_fields
	before_action :find_optional_project
	# after_action :rebuild_project_menu, only: :settings_update
	def settings_update
		if params['list_ids'].blank?
			ProjectList.where(project_id: @project.id).delete_all
		else
			params['list_ids'].each do |list|
				if ProjectList.where(project_id: @project.id, list_id: list).blank?
					ProjectList.create!(project_id: @project.id, list_id: list)
				end
			end
			deleted_lists = ProjectList.where(project_id: @project.id).pluck(:list_id) - params['list_ids'].map(&:to_i)
			if deleted_lists.present?
				ProjectList.where(project_id: @project.id).where(list_id: deleted_lists).delete_all
			end
		end
		flash[:notice] = "Successfully updated"
		redirect_to settings_project_path(@project, :tab => 'lists')
	end

	def index
		@list = List.find_by_id(params[:list_id])
		@plist = ProjectList.where(list_id: @list.try(:id), project_id: @project.id).first
		if @list.blank? || @plist.blank?
			raise ::Unauthorized
		end
		@items = ListItem.where(project_list_id: @plist.id)
		@current_menu_item = @list.name.underscore.to_sym
	end

	def create
		@list = List.find_by_id(params[:list_id])
		@plist = ProjectList.where(list_id: @list.try(:id), project_id: @project.id).first
		if @list.blank? || @plist.blank? || params[:project_list].blank?
			raise ::Unauthorized
		end
		@list_item = ListItem.new(project_list_id: @plist.id, created_by: User.current.id, updated_by: User.current.id)
		params[:project_list][:custom_field_values] = params[:project_list][:custom_field_values].select{|cfk,cfv| cfv.present? }
		@list_item.custom_field_values=(params[:project_list][:custom_field_values])
		if @list_item.save
			flash[:notice] = "Successfully created the #{@list.name}"
			redirect_to(projects_lists_path(@project,@list))
		else
			flash[:error] = "Error: #{@list_item.errors.full_messages.join(", ")}"
			render :new
		end
		@current_menu_item = @list.name.underscore.to_sym
	end

	def destroy
		@item = ListItem.find_by_id(params[:list_id])
		@plist = @item.try(:project_list)
		@list = @plist.try(:list)
		if @list.blank? || @plist.blank? || params[:list_items].blank?
			raise ::Unauthorized
		end
		@item.destroy
		flash[:notice] = "Successfully updated the #{@list.name}"
		redirect_to(projects_lists_path(@project,@list))
	end

	def update
		@item = ListItem.find_by_id(params[:list_id])
		@plist = @item.try(:project_list)
		@list = @plist.try(:list)
		if @list.blank? || @plist.blank? || params[:list_items].blank?
			raise ::Unauthorized
		end
		@item.updated_by = User.current.id
		@item.custom_field_values=(params[:list_items][:custom_field_values])
		if @item.save
			flash[:notice] = "Successfully updated the #{@list.name}"
			redirect_to(projects_lists_path(@project,@list))
		else
			flash[:error] = "Error: #{@item.errors.full_messages.join(", ")}"
			render :edit
		end
	end

	def edit
		@item = ListItem.find_by_id(params[:list_id])
		@plist = @item.try(:project_list)
		@list = @plist.try(:list)
		if @item.blank? || @plist.blank? || @item.blank?
			raise ::Unauthorized
		end
	end

	def new
		@list = List.find(params[:list_id])
		@current_menu_item = @list.name.underscore.to_sym
		@plist = ProjectList.where(list_id: @list.id, project_id: @project.id).first
		@list_item = ListItem.new(project_list_id: @plist.id,created_by: User.current.id,updated_by: User.current.id)
		if @plist.blank?
			raise ::Unauthorized
		end
	rescue
		raise ::Unauthorized
	end

	private

	def rebuild_project_menu
		Redmine::MenuManager.map :project_menu do |menu|
			binding.pry
		    # menu.delete(:testing)
		    # if some_condition
		    #   menu.push :custom_tab,
		    #             { controller: 'custom', action: 'index' },
		    #             caption: 'Custom Tab',
		    #             param: :project_id,
		    #             after: :activity
		    # end
		end
	end

	def permit_param
		params.require(:list).permit(:name, :description, :global)
	end
end