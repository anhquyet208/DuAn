class UserController < UserApplicationController
  def index
  end

  def check_in
      @checked_in = true
      save_request_information(:check_in)
      redirect_to user_path(check_in: true)
    end

    def check_out
      @checked_in = false
      save_request_information(:check_out)
      redirect_to user_path
    end

  private
  def save_request_information(request_type)
    request = Request.new(user_id: current_user.id, request_type: request_type, status: :open)
    request.build_request_infor(date_request: DateTime.now)
    request.save
  end
end
