class AddConfirmableToAdmins < ActiveRecord::Migration
  def up
    add_column :admins, :unconfirmed_email, :string
    add_column :admins, :confirmation_token, :string
    add_column :admins, :confirmed_at, :datetime
    add_column :admins, :confirmation_sent_at, :datetime
    Admin.update_all(:confirmed_at => Time.now)
  end

  def down
    remove_column :admins, :unconfirmed_email, :confirmation_token, :confirmed_at, :confirmation_sent_at
  end
end
