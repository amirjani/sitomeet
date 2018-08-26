class CreateGroupUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :group_users, id: :uuid do |t|

      t.references :user, type: :uuid, null: false, index: true ,foreign_key: { on_delete: :cascade , on_update: :cascade }
      t.references :group, type: :uuid, null: false, index: true ,foreign_key: { on_delete: :cascade , on_update: :cascade }
      t.integer :status , default: 0
      t.boolean :is_admin , default: false

      t.timestamps
    end
  end
end
