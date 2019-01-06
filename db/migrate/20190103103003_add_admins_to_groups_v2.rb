class AddAdminsToGroupsV2 < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :admins
    add_column :groups, :admins, :string, array: true, default: []
  end
end
