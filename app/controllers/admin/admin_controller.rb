class Admin::AdminController < ActionController::Base
  protect_from_forgery
  layout 'admin'
  before_filter :authenticate_admin!

  def after_sign_in_path_for
    admin_path
	end

end