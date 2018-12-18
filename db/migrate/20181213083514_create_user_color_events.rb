class CreateUserColorEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :user_color_events, id: :uuid do |t|
      
      t.references :user , type: :uuid , null: false , index: true ,foreign_key: { on_delete: :cascade , on_update: :cascade }
      
      t.integer :event_type , null: false
      t.integer :event_color , null: false  

      t.timestamps
    end
  end
end
