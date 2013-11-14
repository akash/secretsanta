class Admin::UsersController < Admin::AdminController

	def exclusions
		@user = User.find params[:id]
		@party_id = params[:party_id]

		@users = current_admin.users.reject{|user| user == @user}
	end

	def create_exclusions
		@user = User.find(params[:id])
		@user.exclusions.clear

		if params[:user] && !params[:user][:exclusions].blank?
			exclusions = params[:user][:exclusions].keys.map{|id| Exclusion.new(:excluded_user_id => id)}
			@user.exclusions = exclusions
		end
		redirect_to admin_path(params[:party_id]), :notice => "Successfully updated exclusions for #{@user.full_name}"
	end

	def exclude
		respond_to do |format|
			format.json do
				@user = User.find(params[:id])
				@user.exclusions << Exclusion.new(:excluded_user_id => params[:excluded_user_id])
				render :json => {:success => true}
			end
		end
	end

	def include
		respond_to do |format|
			format.json do
				@user = User.find(params[:id])
				@user.exclusions.find_by_excluded_user_id(params[:included_user_id]).delete
				render :json => {:success => true}
			end
		end
	end

end