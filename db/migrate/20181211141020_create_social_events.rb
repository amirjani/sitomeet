class CreateSocialEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :social_events, id: :uuid do |t|

      t.string :title , null: false
      t.string :description

      t.integer :price , null: true

      t.boolean :is_available , default:true
      t.integer :capacity , null: true

      t.boolean :is_accepted , default: false

      t.timestamps
    end
  end
end
