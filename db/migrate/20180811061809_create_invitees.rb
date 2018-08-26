class CreateInvitees < ActiveRecord::Migration[5.2]
  def change
    create_table :invitees, id: :uuid do |t|
      t.string :name
      t.references :invite_friends , type: :uuid, null: false, index: true ,foreign_key: { on_delete: :cascade , on_update: :cascade }

      t.timestamps
    end
  end
end
