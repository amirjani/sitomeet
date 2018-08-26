class CreateShareEventTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :share_event_types, id: :uuid do |t|

      t.references :type, type: :uuid, null: false, index: true ,foreign_key: { on_delete: :cascade , on_update: :cascade }

      t.references :share_event, type: :uuid, null: false, index: true ,foreign_key: { on_delete: :cascade , on_update: :cascade }

      t.timestamps
    end
  end
end
