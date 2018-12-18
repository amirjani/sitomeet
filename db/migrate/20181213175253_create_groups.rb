class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups, id: :uuid do |t|
      t.string :name, null: false
      t.text :description
      t.boolean :is_private, default: false
      t.text :link

      t.timestamps
    end
  end
end
