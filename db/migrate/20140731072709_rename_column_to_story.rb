class RenameColumnToStory < ActiveRecord::Migration
  def change
    rename_column :stories, :content, :contents
  end
end
