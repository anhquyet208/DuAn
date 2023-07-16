class AddDayOfBrithToAdminUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :admin_users, :day_of_brith, :date
  end
end
