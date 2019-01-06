class RenameColumnSocialEvent < ActiveRecord::Migration[5.2]
  def change
    rename_column :social_events , :social_event_types_id , :social_event_type_id
    rename_column :social_events , :social_event_categories_id , :social_event_category_id 
  end
end
