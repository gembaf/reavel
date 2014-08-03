class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :novel_id,  null: false
      t.string :title,      default: "notitle"
      t.string :contents
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
