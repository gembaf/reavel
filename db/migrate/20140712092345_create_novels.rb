class CreateNovels < ActiveRecord::Migration
  def change
    create_table :novels do |t|
      t.string  :title,     default: "notitle"
      t.text    :summary,   default: ""
      t.string  :comment,   default: ""
      t.integer :mode,      default: 0
      t.integer :time,      default: 0
      t.integer :episode,   default: 0
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
