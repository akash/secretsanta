class Admin::InvitationsController < Admin::AdminController

	EMAIL_REGEXP = /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i

  def create
		invitees = params[:invitees].select {|invitee| EMAIL_REGEXP.match(invitee) }

		party_id = params[:party_id]
		invitees.each {|invitee|  UserMailer.invite(current_admin, invitee, new_user_party_registration_url(party_id)).deliver}

		redirect_to admin_party_path(party_id), :flash => {:notice => "Successfully invited #{invitees.size} people."}
	end

end