class CreateInvites < ActiveRecord::Migration[5.2]
  def change
    create_table :invites, id: :uuid do |t|

      t.references :user , type: :uuid , null: false , index: true ,foreign_key: { on_delete: :cascade , on_update: :cascade }
     
      t.integer :number_of_along , null: true

      t.timestamps
    end
  end
end
