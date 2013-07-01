class HomeController < ApplicationController

	def index
		redirect_to my_secret_santa_path(:user_id => current_user.id, :party_id => current_user.party.id) if user_signed_in?
	end

end