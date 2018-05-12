class CreateChapters < ActiveRecord::Migration[5.1]
  def change
    create_table :chapters do |t|
      t.string :title
      t.string :comment
      t.integer :no,       null: false
      t.integer :novel_id, null: false

      t.timestamps
    end
  end
end
