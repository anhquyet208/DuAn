class UserApplicationController < ActionController::Base
  before_action :authenticate_user!
  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser)
      '/admin'
    elsif resource.is_a?(User)
      '/user'
    else
      ''
    end
  end
end
