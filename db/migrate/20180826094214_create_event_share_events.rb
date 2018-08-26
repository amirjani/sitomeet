class CreateEventShareEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :event_share_events, id: :uuid do |t|

      t.references :event, type: :uuid, null: false, index: true ,foreign_key: { on_delete: :cascade , on_update: :cascade }
      t.references :share_event, type: :uuid, null: false, index: true ,foreign_key: { on_delete: :cascade , on_update: :cascade }

      t.timestamps
    end
  end
end
