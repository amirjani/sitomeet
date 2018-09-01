class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events, id: :uuid do |t|

      t.boolean :is_private , default: true
      t.string :title , null: false
      t.string :description , null: true
      t.datetime :start_time , null: false
      t.datetime :end_time , null: false
      t.datetime :notification_time , null: true
      t.integer :when_to_repeat , null: true
      t.boolean :is_verified
      t.boolean :is_with , null: true , default: false

      t.timestamps
    end
  end
end
