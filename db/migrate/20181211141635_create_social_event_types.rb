class CreateSocialEventTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :social_event_types, id: :uuid do |t|

      t.string :title , null: false

      t.timestamps
    end
  end
end
