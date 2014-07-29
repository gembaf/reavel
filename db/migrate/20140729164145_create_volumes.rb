class CreateVolumes < ActiveRecord::Migration
  def change
    create_table :volumes do |t|
      t.integer :part_id,    null: false
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
