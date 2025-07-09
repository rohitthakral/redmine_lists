module CustomFieldsHelperPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      # unloadable
        # CUSTOM_FIELDS_TABS = [
        #   {:name => 'IssueCustomField', :partial => 'custom_fields/index',
        #    :label => :label_issue_plural},
        #   {:name => 'TimeEntryCustomField', :partial => 'custom_fields/index',
        #    :label => :label_spent_time},
        #   {:name => 'ProjectCustomField', :partial => 'custom_fields/index',
        #    :label => :label_project_plural},
        #   {:name => 'VersionCustomField', :partial => 'custom_fields/index',
        #    :label => :label_version_plural},
        #   {:name => 'DocumentCustomField', :partial => 'custom_fields/index',
        #    :label => :label_document_plural},
        #   {:name => 'UserCustomField', :partial => 'custom_fields/index',
        #    :label => :label_user_plural},
        #   {:name => 'GroupCustomField', :partial => 'custom_fields/index',
        #    :label => :label_group_plural},
        #   {:name => 'TimeEntryActivityCustomField', :partial => 'custom_fields/index',
        #    :label => TimeEntryActivity::OptionName},
        #   {:name => 'IssuePriorityCustomField', :partial => 'custom_fields/index',
        #    :label => IssuePriority::OptionName},
        #   {:name => 'DocumentCategoryCustomField', :partial => 'custom_fields/index',
        #    :label => DocumentCategory::OptionName},
        #   {:name => 'ListCustomField', :partial => 'custom_fields/index',
        #    :label => :label_list_plural}
        # ]
    end
  end
  module InstanceMethods
  end
end

unless CustomFieldsHelper.included_modules.include?(CustomFieldsHelperPatch)
  CustomFieldsHelper.send(:include, CustomFieldsHelperPatch)
end
