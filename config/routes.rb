Secretsanta::Application.routes.draw do
  devise_for :admin
  devise_for :users

  root :to => "home#index"
  match "/admin" => "admin/parties#index"

  namespace :admin do
    resources :parties do
      resources :invitations
      resources :users
    end
  end

end
