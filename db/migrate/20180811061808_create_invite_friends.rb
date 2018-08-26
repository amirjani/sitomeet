class CreateInviteFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :invite_friends, id: :uuid do |t|

      t.references :events, type: :uuid, null: false, index: true ,foreign_key: { on_delete: :cascade , on_update: :cascade }
      t.integer :number

      t.timestamps
    end
  end
end
