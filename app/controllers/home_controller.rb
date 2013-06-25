class HomeController < ApplicationController

	def index
		user = current_user
		redirect_to my_secret_santa_path(:user_id => user.id, :party_id => user.party.id) if current_user
	end

end