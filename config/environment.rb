# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Secretsanta::Application.initialize!

ActionMailer::Base.smtp_settings = {
		:address        => 'smtp.sendgrid.net',
		:port           => '587',
		:authentication => :plain,
		:user_name      => 'app16351475@heroku.com',
		:password       => '2gwwheae',
		:domain         => 'heroku.com',
		:enable_starttls_auto => true
}