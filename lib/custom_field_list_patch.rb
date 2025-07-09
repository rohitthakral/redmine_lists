module CustomFieldListPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      has_and_belongs_to_many :lists,
        :join_table => "#{table_name_prefix}custom_fields_lists#{table_name_suffix}",
        :foreign_key => "custom_field_id"
    end
  end
  module InstanceMethods
  end
end

unless CustomField.included_modules.include?(CustomFieldListPatch)
  CustomField.send(:include, CustomFieldListPatch)
end
