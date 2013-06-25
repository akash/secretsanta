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
      resources :invitations
      resources :registrations
    end
  end

end
