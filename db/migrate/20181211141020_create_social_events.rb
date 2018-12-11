class CreateSocialEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :social_events, id: :uuid do |t|

      t.references :users , type: :uuid , null: false , index: true ,foreign_key: { on_delete: :cascade , on_update: :cascade }

      t.string :title , null: false
      t.string :description

      t.references :social_event_types , type: :uuid , null: true , index: true ,foreign_key: { on_delete: :cascade , on_update: :cascade }
      t.references :social_event_categories , type: :uuid , null: true , index: true ,foreign_key: { on_delete: :cascade , on_update: :cascade }

      t.integer :price , null: true

      t.boolean :is_available , default:true
      t.integer :capacity , null: true

      t.boolean :is_accepted , default: false

      t.timestamps
    end
  end
end
