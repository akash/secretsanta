class Admin::AdminController < ActionController::Base
  protect_from_forgery
  layout 'admin'
  before_filter :authenticate_admin!

  def after_sign_in_path_for
    admin_path
	end

	def show
		@party = current_admin
	end

	def launch
		party.launch
		party.users.each {|user| UserMailer.delay.party_launched(party, user, root_url)}
		redirect_to admin_path(party), :notice => "Let's get this party started! Participants have been emailed informing them the party is now launched"
	end

	def reset_details
		@party = current_admin
	end

	def reset
		party.reset
		party.users.each {|user| UserMailer.delay.party_reset(party, user, params[:message])}
		redirect_to admin_parties_path, :notice => "Your party has been reset. All members have been notified and will have to wait for you to relaunch the party before they can log in and pick their new names"
	end

end