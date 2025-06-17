class CreateLists < ActiveRecord::Migration[6.1]
  def change
    create_table :lists do |t|
      t.string :name
      t.text :description
      t.boolean :global, default: false
      t.integer :author_id
      t.timestamps
    end
  end
end
