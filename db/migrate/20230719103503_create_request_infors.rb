class CreateRequestInfors < ActiveRecord::Migration[7.0]
  def change
    create_table :request_infors do |t|
      t.integer :request_id
      t.date :date_request
      t.time :check_in
      t.time :check_out
      t.date :from
      t.date :to
      t.timestamps
    end
  end
end
