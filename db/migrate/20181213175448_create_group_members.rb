class CreateGroupMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :group_members, id: :uuid do |t|
      t.references :user, foreign_key: true, type: :uuid
      t.references :group, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
