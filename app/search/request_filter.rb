class RequestFilter
  attr_reader :params
  def initialize(params)
    @params = params
  end

  def search
    request = Request.all
    if params[:request].present?
      if params[:request][:user_id].present?
        request = request.where(user_id: params[:request][:user_id])
      end
      if params[:request][:request_type].present?
        request = request.where(request_type: params[:request][:request_type])
      end
      if params[:request][:request_infor_attributes][:date_request].present?
        request = request.joins(:request_infor).where(request_infors: { date_request: params[:request][:request_infor_attributes][:date_request] })
      end
    end
    request.paginate(page: params[:page].to_i.nonzero? || 1, per_page: params[:per_page].to_i.nonzero? || 7)
  end
end
