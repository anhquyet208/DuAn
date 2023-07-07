Rails.application.routes.draw do
  get '/admin', to: 'admin/admin_users#index'
end
