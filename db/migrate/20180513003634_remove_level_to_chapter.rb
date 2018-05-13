class RemoveLevelToChapter < ActiveRecord::Migration[5.1]
  def change
    remove_index :chapters, [:parent_id, :level, :no]
    remove_column :chapters, :level, :integer, default: 1, null: false
    remove_column :chapters, :parent_id, :integer

    add_column :chapters, :parent_id, :integer, default: 0, null: false
    add_index :chapters, [:parent_id, :no]
  end
end
