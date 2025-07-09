$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/lib/"
require 'custom_fields_helper_patch'
require 'custom_field_list_patch'
require 'projects_helper_list_patch'
Redmine::Plugin.register :redmine_lists do
  name 'Redmine Lists Plugin'
  author 'Target Integration'
  description 'A plugin to manage custom lists within Redmine'
  version '0.0.1'
  requires_redmine version_or_higher: '5.0.0'

  project_module :lists do
    permission :manage_lists, projects_lists: [:new, :index, :settings_update, :create, :edit, :update, :destroy]
  end

  Redmine::MenuManager.map :project_menu do |menu|
    List.all.each do |list|
          menu.push list.name.underscore.to_sym, {:controller => 'projects_lists', :action => 'index', list_id: list.id},:after => :issues, :param => :project_id, caption: "#{list.name}",
              :if => Proc.new { |p| ProjectList.where(project_id: p.id, list_id: list.id).present? && User.current.allowed_to?(:manage_lists, p)},
              html: {class: 'list_items_project_menu'}
    end
  end


  menu :admin_menu, :lists, { controller: 'lists', action: 'index' }, 
       caption: 'Redmine Lists', html: { class: 'icon icon-list' }
  CustomField.safe_attributes 'list_ids'
  CustomFieldsHelper::CUSTOM_FIELDS_TABS = [
          {:name => 'IssueCustomField', :partial => 'custom_fields/index',
           :label => :label_issue_plural},
          {:name => 'TimeEntryCustomField', :partial => 'custom_fields/index',
           :label => :label_spent_time},
          {:name => 'ProjectCustomField', :partial => 'custom_fields/index',
           :label => :label_project_plural},
          {:name => 'VersionCustomField', :partial => 'custom_fields/index',
           :label => :label_version_plural},
          {:name => 'DocumentCustomField', :partial => 'custom_fields/index',
           :label => :label_document_plural},
          {:name => 'UserCustomField', :partial => 'custom_fields/index',
           :label => :label_user_plural},
          {:name => 'GroupCustomField', :partial => 'custom_fields/index',
           :label => :label_group_plural},
          {:name => 'TimeEntryActivityCustomField', :partial => 'custom_fields/index',
           :label => TimeEntryActivity::OptionName},
          {:name => 'IssuePriorityCustomField', :partial => 'custom_fields/index',
           :label => IssuePriority::OptionName},
          {:name => 'DocumentCategoryCustomField', :partial => 'custom_fields/index',
           :label => DocumentCategory::OptionName},
          {:name => 'ListCustomField', :partial => 'custom_fields/index',
           :label => :label_list_plural}
        ]
end
