class CreateStories < ActiveRecord::Migration[5.1]
  def change
    create_table :stories do |t|
      t.string  :title
      t.string  :comment
      t.integer :no,                       null: false
      t.integer :time,     default: 0,     null: false
      t.string  :uuid,                     null: false
      t.boolean :is_scene, default: false, null: false

      t.timestamps
    end
  end
end
