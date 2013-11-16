class AddStatusToParty < ActiveRecord::Migration
  def change
		add_column :parties, :status, :string, :default => Admin::STATUS[:pre_launch]
  end
end
