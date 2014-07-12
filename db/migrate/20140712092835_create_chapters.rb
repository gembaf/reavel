class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.integer :novel_id,  null: false
      t.string  :title,     default: "notitle"
      t.string  :comment,   default: ""
      t.integer :serial,    default: 0
      t.integer :time,      default: 0
      t.integer :episode,   default: 0
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
