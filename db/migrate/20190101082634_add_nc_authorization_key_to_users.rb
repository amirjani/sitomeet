class AddNcAuthorizationKeyToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :nc_authorization_key, :string
  end
end
