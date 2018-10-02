class CreateOurLaws < ActiveRecord::Migration[5.2]
  def change
    create_table :our_laws, id: :uuid do |t|

      t.string :title , null: false
      t.text :description , null: false

    end
  end
end
