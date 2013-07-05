class UserMailer < ActionMailer::Base
  default from: "noreply@secretsanta.com"

	def invite(admin, invitee_email, signup_url)
		@signup_url = signup_url
		@admin = admin
		mail(:to => invitee_email, :subject => "#{admin.email} has invited you to join their secret santa party")
	end

	def party_launched(party, user, url)
		@party = party
		@user = user
		@url = url
	end
end