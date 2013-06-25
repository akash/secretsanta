class SecretSantaController < ApplicationController
	before_filter :check_user_logged_in

	def check_user_logged_in
		redirect_to root_url unless current_user

		@user = current_user
	end

end