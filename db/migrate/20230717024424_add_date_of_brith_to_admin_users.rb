class AddDateOfBrithToAdminUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :admin_users, :date_of_brith, :date
  end
end
