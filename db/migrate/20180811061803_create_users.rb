class CreateUsers < ActiveRecord::Migration[5.2]
  require 'securerandom'

  def change
    create_table :users, id: :uuid do |t|
      # fillables
      t.string :first_name, null: false
      t.string :family_name, null: false
      t.string :phone_number , null:false , unique: true , index:true
      t.string :password_digest
      t.string :email , null: false , unique: true
      t.date :birthday , null:false
      t.integer :sex , null:false
      t.integer :role , default: 1
      # fill in update
      t.string :photo , null: true
      t.text :bio , null: true
      t.string :username , null: true
      t.string :location , null: true
      t.boolean :is_private , default:true
      # hidden
      t.string :verification_code , null: false
      t.boolean :verified , default: false
      t.boolean :status , default: true
      t.datetime :verification_code_sent_at
      t.boolean :forget_password

      t.timestamps

    end
  end
end
