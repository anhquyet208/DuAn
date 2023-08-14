module Admin
  class Admin::UsersController < ApplicationController
    def new
     @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        flash[:success] = 'Create New User Successfully'
        redirect_to edit_admin_user_path(@user)
      else
        render :new, status: 422
      end
    end

    def edit
      @user = User.find(params[:id])
      @month = params[:month].present? ? params[:month].to_i : Date.current.month
      @year = params[:year].present? ? params[:year].to_i : Date.current.year
      day = Date.current.day
      @date_time = Date.new(@year, @month, day)
      @working_time = RequestInfor.joins(:request)
        .where('(EXTRACT(month FROM request_infors.date_request) = ? AND EXTRACT(year FROM request_infors.date_request) = ?  AND requests.user_id = ?)', @month, @year, @user.id)
        .order('request_infors.date_request')
        if @month == 1
          @previous_month = 12
          @next_month = @month + 1
          @previous_year = @year - 1
          @next_year = @year
        elsif @month == 12
          @previous_month = @month - 1
          @next_month = 1
          @previous_year = @year
          @next_year = @year + 1
        else
          @previous_month = @month - 1
          @next_month = @month + 1
          @previous_year = @year
          @next_year = @year
        end

      @table_data = []
      (1..@date_time.end_of_month.day).each do |d|
        date = Date.new(@year, @month, d)
        request_infors = RequestInfor.includes(:request).where(date_request: date, requests: { user_id: @user.id })
        table_row = {
          date: date.strftime('%d/%m/%Y'),
          request_type: "",
          from: "",
          to: "",
          check_in: "",
          check_out: "",
          status: ""
        }
        if request_infors.count > 1
          request_status = request_infors.map { |request_infor| request_infor.request.status }
          table_row[:status] = request_status.join(", ")
          if request_status.include?("canceled") && request_status.include?("approved")
            table_row[:status] = "canceled"
          elsif request_status.include?("canceled") && request_status.include?("open")
            table_row[:status] = "canceled"
          elsif request_status.include?("open") && request_status.include?("approved")
            table_row[:status] = "open"
          elsif request_status.include?("approved")
            table_row[:status] = "approved"
          elsif request_status.include?("canceled")
            table_row[:status] = "canceled"
          else
            table_row[:status] = "open"
          end

          request_infors.each do |request_infor|
            request = request_infor.request
            table_row[:request_type] = request.request_type.to_s
            if request.check_in?
              table_row[:check_in] = request_infor.check_in&.strftime('%H:%M')
            else
              table_row[:check_out] = request_infor.check_out&.strftime('%H:%M')
            end
          end

        elsif request_infors.present?
          request_infor = request_infors.first
          table_row[:status] = request_infor.request.status
          request = request_infor.request
          if request.day_off? || request.remote?
            table_row[:request_type] = request.request_type.to_s
            table_row[:from] = request_infor.from&.strftime('%d/%m/%Y')
            table_row[:to] = request_infor.to&.strftime('%d/%m/%Y')
          end
        end
        @table_data << table_row
      end
    end

    def update
      @user = User.find(params[:id])
      user_params_custom = custom_user_params(user_params)
      if @user.update(user_params_custom)
        if user_params[:password].present? && user_signed_in? && current_user.id == @user.id
          sign_in(@user, :bypass => true)
        end
        flash[:success] = 'Update User'
        redirect_to edit_admin_user_path(@user)
      else
        render :edit, status: 422
      end
    end

    def index
      @users = UserFilter.new(params).search
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      flash[:success] = 'User deleted'
      redirect_to admin_users_path
    end

    private
    def user_params
      params.require(:user).permit(:id, :name, :email, :password, :date_of_brith, :tel, :password_confirmation)
    end
    def custom_user_params user_params
      return user_params if user_params[:password].present?
      user_params[:password] = nil
      user_params[:password_confirmation] = nil
      user_params
    end
  end
end
