class Admin::UsersController < Admin::AdminController

	def exclusions
		@users = Party.find(params[:party_id]).users.reject{|user| user.id == params[:id].to_i}
	end

	def create_exclusions
		@user = User.find(params[:id])
		exclusions = params[:user][:exclusions].keys.map{|id| Exclusion.new(:excluded_user_id => id)}
		@user.exclusions = exclusions

		redirect_to admin_party_path(params[:party_id]), :notice => "Successfully edited exclusions for #{@user.email}"
	end

end