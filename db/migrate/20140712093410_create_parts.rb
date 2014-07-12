class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.integer :chapter_id, null: false
      t.string  :title,      default: "notitle"
      t.string  :comment,    default: ""
      t.integer :serial,     default: 0
      t.integer :time,       default: 0
      t.integer :episode,    default: 0
      t.boolean :is_active,  default: true

      t.timestamps
    end
  end
end
