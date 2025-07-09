class CreateListItems < ActiveRecord::Migration[6.1]
  def change
    create_table :list_items do |t|
      t.integer :project_list_id
      t.integer :created_by
      t.integer :last_updated_by

      t.timestamps
    end
  end
end
