class AddPhotoToSocialEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :social_events , :photo , :string , null: true
  end
end
