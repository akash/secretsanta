class Admin::UsersController < Admin::AdminController

	def exclusions
		@user = User.find params[:id]
		@users = Party.find(params[:party_id]).users.reject{|user| user == @user}
	end

	def create_exclusions
		@user = User.find(params[:id])
		@user.exclusions.clear

		if params[:user] && !params[:user][:exclusions].blank?
			exclusions = params[:user][:exclusions].keys.map{|id| Exclusion.new(:excluded_user_id => id)}
			@user.exclusions = exclusions
		end

		redirect_to admin_party_path(params[:party_id]), :notice => "Successfully updated exclusions for #{@user.full_name}"
	end

end