class AdminUserFilter
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def search
    admin_users = AdminUser.all

    if params[:email].present?
      admin_users = admin_users.where("email LIKE ?", "%#{params[:email]}%")
    end

    if params[:tel].present?
      admin_users = admin_users.where("tel LIKE ?", "%#{params[:tel]}%")
    end

    if params[:name].present?
      admin_users = admin_users.where("name LIKE ?", "%#{params[:name]}%")
    end

    admin_users.paginate(page: params[:page], per_page: 3)
  end
end
