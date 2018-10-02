class CreateOurLaws < ActiveRecord::Migration[5.2]
  def change
    create_table :our_laws, id: :uuid do |t|

      t.references :user , type: :uuid, null: false, index: true ,foreign_key: { on_delete: :cascade , on_update: :cascade }
      t.string :title , null: false
      t.text :description , null: false

    end
  end
end
