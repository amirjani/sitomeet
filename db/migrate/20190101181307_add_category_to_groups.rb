class AddCategoryToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :category, :integer
  end
end
