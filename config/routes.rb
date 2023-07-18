Rails.application.routes.draw do
  devise_for :addresses
  devise_for :request_infos
  devise_for :requests
  devise_for :users, path: "",
    path_names: { sign_in: "login", sign_out: "logout" },
    controllers: {
        sessions: 'users/sessions'
    }
  devise_for :admin_users, path: "admin",
    path_names: { sign_in: "login", sign_out: "logout" },
    controllers: {
      sessions: 'admin_users/sessions'
    }
  get "/admin", to: "admin/admin_users#index"
  namespace :admin do
    resources :admin_users
    resources :users
    resource :requests
  end
end