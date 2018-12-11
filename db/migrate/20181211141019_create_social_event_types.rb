class CreateSocialEventTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :social_event_types, id: :uuid do |t|

      t.references :social_event_categories , type: :uuid , null: true , index: true ,foreign_key: { on_delete: :cascade , on_update: :cascade }
      t.string :title , null: false

      t.timestamps
    end
  end
end
