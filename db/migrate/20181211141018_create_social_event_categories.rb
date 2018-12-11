class CreateSocialEventCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :social_event_categories, id: :uuid do |t|

      t.string :title , null: false

      t.timestamps
    end
  end
end
