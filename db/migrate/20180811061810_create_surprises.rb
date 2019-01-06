class CreateSurprises < ActiveRecord::Migration[5.2]
  def change
    create_table :surprises, id: :uuid do |t|
      t.references :event, type: :uuid, null: false, index: true ,foreign_key: { on_delete: :cascade , on_update: :cascade }

      t.string :fake_title
      t.string :fake_description
      t.string :theme

      t.integer :is_invite , null: false , default: true
      t.integer :number_of_along , null: true
      t.integer :user_to_surprise_id , type: :uuid , null: false

      t.timestamps
    end
  end
end
