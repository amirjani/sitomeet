class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups, id: :uuid do |t|

      t.string :title , null:false
      t.boolean :is_muted , default: false
      t.string :image , null: true
      t.boolean :is_private , default: false
      t.boolean :is_verified , default: false
      t.text :description , null:true

      t.timestamps
    end
  end
end
