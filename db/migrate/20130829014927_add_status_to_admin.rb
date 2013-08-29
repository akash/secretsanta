class AddStatusToAdmin < ActiveRecord::Migration
  def change
		add_column :admins, :status, :string, :default => Admin::STATUS[:pre_launch]
  end
end
