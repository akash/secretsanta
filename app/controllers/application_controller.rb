class ApplicationController < ActionController::Base
  protect_from_forgery

	layout :layout_by_resource

	protected

	def layout_by_resource
		if devise_controller? && resource_name == :admin
			"admin"
		else
			"application"
		end
	end

	def after_sign_out_path_for(resource)
		(resource == :admin) ? admin_path : root_path
	end

	def after_sign_in_path_for(resource)
		(resource.kind_of? Admin) ? admin_path : my_secret_santa_path(:user_id => current_user.id, :party_id => current_user.party.id)
	end
end
