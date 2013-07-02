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
end
