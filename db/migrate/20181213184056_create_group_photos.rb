class CreateGroupPhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :group_photos, id: :uuid do |t|
      t.string :file
      t.references :group, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
