module Admin
  class AdminUsersController < ApplicationController
    def index
      @admin_users = AdminUser.all
      if params[:admin_user].present?
        search_params = params.require(:admin_user).permit(:email, :tel, :name)

        if search_params[:email].present?
          @admin_users = @admin_users.where("email LIKE ?", "%#{search_params[:email]}%")
        end

        if search_params[:tel].present?
          @admin_users = @admin_users.where("tel LIKE ?", "%#{search_params[:tel]}%")
        end

        if search_params[:name].present?
          @admin_users = @admin_users.where("name LIKE ?", "%#{search_params[:name]}%")
        end
      end
    end

    def new
      @admin_user = AdminUser.new
    end

    def create
      @admin_user = AdminUser.new(admin_user_params)
      if @admin_user.save
        flash[:success] = 'Create Admin User'
        redirect_to edit_admin_admin_user_path(@admin_user)
      else
        render :new, status: 422
      end
    end

    def edit
      @admin_user = AdminUser.find_by(id: params[:id])
    end

    def update
      @admin_user = AdminUser.find(params[:id])
      admin_user_params_custom = custom_admin_user_params(admin_user_params)
      if @admin_user.update(admin_user_params_custom)
        if admin_user_params[:password].present? && current_admin_user.id == @admin_user.id
          sign_in(@admin_user, :bypass => true)
        end
        flash[:success] = 'Update Admin User'
        redirect_to edit_admin_admin_user_path(@admin_user)
      else
        render :edit, status: 422
      end
    end

    def destroy
      @admin_user = AdminUser.find(params[:id])
      @admin_user.destroy # Soft delete
      flash[:success] = 'Admin User deleted'
      redirect_to admin_admin_users_path
    end

    def restore
      @admin_user = AdminUser.only_deleted.find(params[:id])
      @admin_user.restore # Khôi phục bản ghi đã xóa
      flash[:success] = 'Admin User restored'
      redirect_to admin_admin_users_list_path
    end

    def show
      @admin_user = AdminUser.find(params[:id])
    end

    private
    def admin_user_params
      params.require(:admin_user).permit(:id, :name, :email, :tel, :password, :password_confirmation)
    end

    def custom_admin_user_params admin_user_params
      return admin_user_params if admin_user_params[:password].present?
      admin_user_params[:password] = nil
      admin_user_params[:password_confirmation] = nil
      admin_user_params
    end
  end
end