class CreateNationalEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :national_events, id: :uuid do |t|

      t.references :user , type: :uuid, null: false, index: true ,foreign_key: { on_delete: :cascade , on_update: :cascade }
      t.date :date
      t.boolean :is_day_off
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
