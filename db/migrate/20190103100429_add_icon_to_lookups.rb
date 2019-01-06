class AddIconToLookups < ActiveRecord::Migration[5.2]
  def change
    add_column :lookups, :icon, :string
  end
end
