class RenamePartidToStory < ActiveRecord::Migration
  def change
    rename_column :stories, :part_id, :volume_id
  end
end
