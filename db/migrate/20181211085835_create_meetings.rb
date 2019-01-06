class CreateMeetings < ActiveRecord::Migration[5.2]
  def change
    create_table :meetings, id: :uuid do |t|

      t.references :event , type: :uuid, null: false, index: true ,foreign_key: { on_delete: :cascade , on_update: :cascade }

      t.integer :priority , null: false
      t.integer :is_invite , null: false      
      t.integer :number_of_along , null: true , default: false  
        
      t.timestamps
    end
  end
end
