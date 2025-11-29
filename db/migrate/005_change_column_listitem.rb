class ChangeColumnListitem < ActiveRecord::Migration[6.1]
  def change
    if column_exists?(:list_items, :last_updated_by)
      rename_column :list_items, :last_updated_by, :updated_by
    end
  end
end
