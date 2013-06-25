class Admin::InvitationsController < Admin::AdminController

  def create
		invitees = params[:invitees]
		party_id = params[:party_id]
		invitees.each {|invitee|  UserMailer.invite(current_admin, invitee, new_user_party_registration_url(party_id)).deliver}

		redirect_to admin_party_path(party_id), :flash => {:notice => "Successfully invited #{invitees.size} people."}
	end

end