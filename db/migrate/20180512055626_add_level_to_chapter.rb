class AddLevelToChapter < ActiveRecord::Migration[5.1]
  def change
    add_column :chapters, :level, :integer, default: 1, null: false
    add_column :chapters, :parent_id, :integer
  end
end
