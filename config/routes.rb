Secretsanta::Application.routes.draw do
  #devise_for :admin
	devise_for :admin, :controllers => {:registrations => "admin/registrations"}

  root :to => "home#index"
  match "/admin" => "admin/admin#show"
	match "/users/:user_id/party/:party_id/mysecretsanta" => "secret_santa#index", :as => "my_secret_santa"
	resources :parties do
		devise_for :users, :controllers => { :registrations => "registrations" }
	end

	devise_scope :user do
		get "/login" => "devise/sessions#new"
	end

  namespace :admin do
		post :launch
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
	match "/admin/reset" => "admin/admin#reset_details", :via => "get", :as => "party_reset_details"
	match "/admin/reset" => "admin/admin#reset", :via => "post", :as => "party_reset"

end
