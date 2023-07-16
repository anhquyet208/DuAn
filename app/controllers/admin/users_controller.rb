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
      @user = User.find_by(id: params[:id])
    end

    def update
      @user = User.find(params[:id])
      user_params_custom = custom_user_params(user_params)
      if @user.update(user_params_custom)
        if user_params[:password].present? && current_user.id == @user.id
          sign_in(@user, :bypass => true)
        end
        flash[:success] = 'Update User'
        redirect_to edit_admin_user_path(@user)
      else
        render :edit, status: 422
      end
    end

    def index
      @users = User.all
      if params[:user].present?
        search_params = params.require(:user).permit(:email, :tel, :name)

        if search_params[:email].present?
          @users = @users.where("email LIKE ?", "%#{search_params[:email]}%")
        end

        if search_params[:tel].present?
          @users = @users.where("tel LIKE ?", "%#{search_params[:tel]}%")
        end

        if search_params[:name].present?
          @users = @users.where("name LIKE ?", "%#{search_params[:name]}%")
        end
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy # Soft delete
      flash[:success] = 'User deleted'
      redirect_to admin_users_path
    end

    def restore
      @user = User.only_deleted.find(params[:id])
      @user.restore # Khôi phục bản ghi đã xóa
      flash[:success] = 'Admin User restored'
      redirect_to admin_users_path
    end

    private
    def user_params
      params.require(:user).permit(:name, :email, :password, :date_of_brith, :tel)
    end
    def custom_user_params user_params
      return user_params if user_params[:password].present?
      user_params[:password] = nil
      user_params[:password_confirmation] = nil
      user_params
    end
  end
end