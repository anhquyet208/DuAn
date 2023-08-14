class Request < ApplicationRecord
  has_one :request_infor, dependent: :destroy
  enum request_type: {
    check_in: 1,
    check_out: 2,
    day_off: 3,
    remote: 4
  }

  enum status: {
    open: 1,
    approved: 2,
    canceled: 3
  }
  belongs_to :user
  accepts_nested_attributes_for :request_infor
end
