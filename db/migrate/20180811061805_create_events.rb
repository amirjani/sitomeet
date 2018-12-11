class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events, id: :uuid do |t|

      t.integer :type , null: false
      t.integer :color , null: true , default: 0

      t.date :date , null: false

      t.string :title , null: false
      t.string :description , null: true

      t.string :location_name , null: false
      t.string :location_lat , null: false
      t.string :location_long , null: false

      t.string :address , null: false

      t.datetime :start_time , null: false
      t.datetime :end_time , null: false

      t.integer :repeat_time , null: false
      t.integer :notification_time , null: false
      t.datetime :end_of_repeat , null: false

      t.boolean :is_private , default: true
      t.boolean :is_verified , null: true

      t.string :photo , null: true

      t.timestamps

    end
  end
end
