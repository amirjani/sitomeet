class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events, id: :uuid do |t|

      t.boolean :is_private
      t.string :title
      t.string :description
      t.date :start_time
      t.date :end_time
      t.date :notification_time
      t.integer :when_to_repeat
      t.boolean :is_verified
      t.boolean :is_with

      t.timestamps
    end
  end
end
