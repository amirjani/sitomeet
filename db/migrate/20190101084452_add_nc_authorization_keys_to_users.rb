class AddNcAuthorizationKeysToUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :nc_authorization_key
    add_column :users, :nc_android_authorization_key, :string
    add_column :users, :nc_ios_authorization_key, :string
    add_column :users, :nc_web_authorization_key, :string
  end
end
