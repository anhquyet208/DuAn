Rails.application.routes.draw do
  devise_for :admin_users, path: "/admin",
    path_names: {:sign_in => "login", :sign_out => "logout"} ,
    controllers: {
      sessions: 'admin_users/sessions'
    }
  get '/admin', to: 'admin/admin_users#index'
end
