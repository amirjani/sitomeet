class CreateTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :types, id: :uuid do |t|
      t.string :title
      t.text :description
      t.integer :color
      t.boolean :is_verified , default: false , unique: true
      t.timestamps
    end
  end
end
