class Admin::InvitationsController < Admin::AdminController

	EMAIL_REGEXP = /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i

  def create
		invitees = params[:invitees].select {|invitee| EMAIL_REGEXP.match(invitee) }
		invitees.each {|invitee|  UserMailer.delay.invite(current_admin, invitee, new_user_party_registration_url(current_admin.id))}
		redirect_to admin_path, :flash => {:notice => "Successfully invited #{invitees.size} people."}
	end

end