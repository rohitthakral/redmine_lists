module ProjectsHelperListPatch
  def self.included(base)
    base.send :include, InstanceMethods
    base.class_eval do
      unloadable
      alias_method :project_settings_tabs_without_list, :project_settings_tabs
      alias_method :project_settings_tabs, :project_settings_tabs_with_list
    end
  end

  module InstanceMethods
    def project_settings_tabs_with_list
      tabs = project_settings_tabs_without_list
      tab = {:name => 'lists',
      :label => :label_list_plural,
      :partial => 'settings/list_settings'
      }
      tabs << tab if User.current.allowed_to?(:manage_lists, @project)
      tabs
    end
  end
end

unless ProjectsHelper.included_modules.include?(ProjectsHelperListPatch)
  ProjectsHelper.send(:include, ProjectsHelperListPatch)
end
