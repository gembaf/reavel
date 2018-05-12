class ChapterHasManyStoryRelation < ActiveRecord::Migration[5.1]
  def change
    add_column :stories, :chapter_id, :integer, null: false
  end
end
