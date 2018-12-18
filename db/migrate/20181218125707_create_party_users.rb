
class CreatePartyUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :party_users, id: :uuid do |t|
 
      t.references :party , type: :uuid, null: false, index: true ,foreign_key: { on_delete: :cascade , on_update: :cascade }
      t.references :user , type: :uuid , null: false , index: true , foreign_key: { on_delete: :cascade , on_update: :cascade }     
 
      t.timestamps
    end
  end
end
