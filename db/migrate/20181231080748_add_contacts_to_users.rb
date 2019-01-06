class AddContactsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :contacts, :string, array: true, default: []
  end
end
