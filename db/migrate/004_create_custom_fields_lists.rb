class CreateCustomFieldsLists < ActiveRecord::Migration[6.1]
  def self.up
    create_table :custom_fields_lists, :id => false do |t|
      t.column :custom_field_id, :integer, :null => false
      t.column :list_id, :integer, :null => false
    end
    add_index :custom_fields_lists, [:custom_field_id, :list_id], :unique => true, :name => :custom_fields_lists_ids
  end

  def self.down
    drop_table :custom_fields_lists
  end
end