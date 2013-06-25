class RegistrationsController < Devise::RegistrationsController
	skip_before_filter :check_user_logged_in
	skip_before_filter :authenticate_user!

	def new
		@party = Party.find params[:party_id]
		@user = User.new
	end

	def create
		@party = Party.find params[:party_id]
		@user = User.new params[:user]
		if @user.valid?
			@party.users << @user
			@party.save!
			redirect_to root_path, :notice => "You have successfully signed up"
		else
			render :new
		end

	end
end