class User::RequestsController < UserApplicationController

  def new
    @request = Request.new
    @request.build_request_infor
  end

  def create
    @request = Request.new(request_params)
    @request.user_id = current_user.id
    @request.status = params[:request][:status]
    if @request.save
      flash[:success] = 'Create Request Successfully'
      redirect_to edit_user_request_path(@request)
    else
      render :new, status: 422
    end
  end

  def edit
    @request = Request.find_by(id: params[:id])
  end

  def update
    @request = Request.find(params[:id])
    if @request.update(request_params)
      flash[:success] = 'Request updated successfully.'
      redirect_to edit_user_request_path(@request)
    else
      flash.now[:error] = @request.errors.full_messages.join(', ')
      render :edit
    end
  end
  def index
    @requests = current_user.requests
  end
  private
  def request_params
    params.require(:request).permit(
      :id, :request_type, :status, :user_id, :admin_user_id,
      request_infor_attributes: [:id, :request_id, :date_request, :from, :to, :check_in, :check_out]
    )
  end
end
