Secretsanta::Application.routes.draw do
  devise_for :admin

  root :to => "home#index"
  match "/admin" => "admin/parties#index"
	resources :parties do
		devise_for :users
	end

  namespace :admin do
    resources :parties do
      resources :invitations
      resources :users
    end
  end

end
