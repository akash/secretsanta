Admin.create! :user_name => "akash", :email => "akash@thoughtworks.com", :password => "password", :password_confirmation => "password"
Admin.update_all(:confirmed_at => Time.now)