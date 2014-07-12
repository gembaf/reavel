class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.integer :part_id,   null: false
      t.string  :title,     default: "notitle"
      t.string  :comment,   default: ""
      t.string  :content
      t.integer :serial,    default: 0
      t.integer :time,      default: 0
      t.boolean :is_scene,  default: false
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
