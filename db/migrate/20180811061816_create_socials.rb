class CreateSocials < ActiveRecord::Migration[5.2]
  def change
    create_table :socials, id: :uuid do |t|
      t.references :user , type: :uuid, null: false, index: true ,foreign_key: { on_delete: :cascade , on_update: :cascade }
      t.integer :name , unique:true
      t.string :link , unique:true
      t.timestamps
    end
  end
end
