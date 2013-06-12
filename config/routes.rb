Secretsanta::Application.routes.draw do
  devise_for :users

  root :to => "home#index"
  match "/admin" => "admin/home#index"

  namespace :admin do
    resources :users
    resources :groups
  end
end
