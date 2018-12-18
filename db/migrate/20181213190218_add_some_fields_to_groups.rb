class AddSomeFieldsToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :owner, :uuid, index: true
  end
end
