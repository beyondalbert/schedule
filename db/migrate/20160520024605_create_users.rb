class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.string :auth_token
      t.integer :status
      t.string :password_reset_token
      t.datetime :password_reset_sent_at

      t.timestamps null: false
    end
  end
end
