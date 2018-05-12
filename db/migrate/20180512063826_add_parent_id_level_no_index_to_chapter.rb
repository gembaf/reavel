class AddParentIdLevelNoIndexToChapter < ActiveRecord::Migration[5.1]
  def change
    add_index :chapters, [:parent_id, :level, :no]
  end
end
