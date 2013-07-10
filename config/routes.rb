Secretsanta::Application.routes.draw do
  devise_for :admin

  root :to => "home#index"
  match "/admin" => "admin/parties#index"
	match "/users/:user_id/party/:party_id/mysecretsanta" => "secret_santa#index", :as => "my_secret_santa"
	resources :parties do
		devise_for :users, :controllers => { :registrations => "registrations" }
	end

	devise_scope :user do
		get "/login" => "devise/sessions#new"
	end

  namespace :admin do
    resources :parties do
			post :launch
			post :reset
      resources :invitations
      resources :registrations
			resources :users do
				member do
					get :exclusions
					post :create_exclusions
					post :exclude
					post :include
				end
			end
    end
  end

end
