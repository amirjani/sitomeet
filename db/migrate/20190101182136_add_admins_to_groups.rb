class AddAdminsToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admins, :string, array: true, default: []
  end
end
