module Admin
  class RequestsController < ApplicationController

    def new
    end

    private
    def requests_params
      params.require(:request).permit()
    end
  end
end
