class Admin::PartiesController < Admin::AdminController

  def show
		@party = current_admin
	end

	def launch
		party = current_admin
		return redirect_to admin_path(:notice => "Hey hey, none of that! You can only launch a party that you started") unless party.admin == current_admin
		party.launch
		party.users.each {|user| UserMailer.delay.party_launched(party, user, root_url)}
		redirect_to admin_party_path(party), :notice => "Let's get this party started! Participants have been emailed informing them the party is now launched"
	end

	def reset_details
		@party = current_admin
	end

	def reset
		party = current_admin
		return redirect_to admin_path(:notice => "Hey hey, none of that! You can only reset a party that you started") unless party.admin == current_admin
		party.reset
		party.users.each {|user| UserMailer.delay.party_reset(party, user, params[:message])}
		redirect_to admin_parties_path, :notice => "Your party has been reset. All members have been notified and will have to wait for you to relaunch the party before they can log in and pick their new names"
	end
end