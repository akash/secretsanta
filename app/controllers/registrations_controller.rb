class RegistrationsController < Devise::RegistrationsController
	skip_before_filter :check_user_logged_in
	skip_before_filter :authenticate_user!

	def new
		@party = Admin.find params[:party_id]
		puts "*"*100
		puts @party.inspect
		puts "*"*100
		@user = User.new
	end

	def create
		@party = Admin.find params[:party_id]
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