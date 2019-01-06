class CreateLookups < ActiveRecord::Migration[5.2]
  def change
    create_table :lookups, id: :uuid do |t|
      t.string :title
      t.integer :code
      t.string :category

      t.timestamps
    end
  end
end
