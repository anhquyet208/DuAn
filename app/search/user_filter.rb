class UserFilter
  attr_reader :params
  def initialize(params)
    @params = params
  end

  def search
    users = User.all

    if params[:email].present?
      users = users.where("email LIKE ?", "%#{params[:email]}%")
    end

    if params[:tel].present?
      users = users.where("tel LIKE ?", "%#{params[:tel]}%")
    end

    if params[:name].present?
      users = users.where("name LIKE ?", "%#{params[:name]}%")
    end

    users.paginate(page: params[:page], per_page:3)
  end
end
