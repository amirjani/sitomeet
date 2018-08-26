class CreateGroupTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :group_types, id: :uuid do |t|

      t.references :group, type: :uuid, null: false, index: true ,foreign_key: { on_delete: :cascade , on_update: :cascade }
      t.references :type, type: :uuid, null: false, index: true ,foreign_key: { on_delete: :cascade , on_update: :cascade }

      t.timestamps
    end
  end
end
