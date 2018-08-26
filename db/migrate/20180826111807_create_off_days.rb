class CreateOffDays < ActiveRecord::Migration[5.2]
  def change
    create_table :off_days, id: :uuid do |t|

      t.references :user, type: :uuid, null: false, index: true ,foreign_key: { on_delete: :cascade , on_update: :cascade }
      t.date :date , null:false
      t.date :description , null: true

      t.timestamps
    end
  end
end
