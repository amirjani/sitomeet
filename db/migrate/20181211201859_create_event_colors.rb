class CreateEventColors < ActiveRecord::Migration[5.2]
  def change
    create_table :event_colors, id: :uuid do |t|

      t.integer :type , null: false
      t.integer :color , null: false

      t.timestamps
    end
  end
end
