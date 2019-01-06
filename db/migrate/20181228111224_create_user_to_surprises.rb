class CreateUserToSurprises < ActiveRecord::Migration[5.2]
  def change
    create_table :user_to_surprises, id: :uuid do |t|

      t.timestamps
    end
  end
end
