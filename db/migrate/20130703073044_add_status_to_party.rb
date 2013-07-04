class AddStatusToParty < ActiveRecord::Migration
  def change
		add_column :parties, :status, :string, :default => Party::STATUS[:pre_launch]
  end
end
