class CreateSurprises < ActiveRecord::Migration[5.2]
  def change
    create_table :surprises, id: :uuid do |t|
      t.references :event, type: :uuid, null: false, index: true ,foreign_key: { on_delete: :cascade , on_update: :cascade }

      t.string :fake_title
      t.string :fake_description
      t.string :theme

      t.timestamps
    end
  end
end
