class Admin::RegistrationsController < Devise::RegistrationsController
	skip_before_filter :check_admin_logged_in
	skip_before_filter :authenticate_admin!

	def new
		@party = Admin.new
	end

	def create
		@party = Admin.new params[:admin]
		if @party.valid?
			@party.save!
			redirect_to admin_path, :notice => "You have successfully signed up"
		else
			render :new
		end
	end

end