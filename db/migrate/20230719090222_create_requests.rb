class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.integer :admin_user_id
      t.integer :user_id
      t.integer :request_type, default: 1
      t.integer :status, default: 1
      t.timestamps
    end
  end
end
