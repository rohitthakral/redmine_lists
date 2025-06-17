class CreateProjectLists < ActiveRecord::Migration[6.1]
  def change
    create_table :project_lists do |t|
      t.integer :project_id
      t.integer :list_id
    end
  end
end
