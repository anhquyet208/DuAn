# frozen_string_literal: true

class DeviseCreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.string :requesttable_id
      t.string :requesttable_type

      t.integer :type
      t.integer :status

      t.datetime :remember_created_at

      t.timestamps null: false
    end

    # add_index :requests, :email,                unique: true
    # add_index :requests, :reset_password_token, unique: true
    # add_index :requests, :confirmation_token,   unique: true
    # add_index :requests, :unlock_token,         unique: true
  end
end
