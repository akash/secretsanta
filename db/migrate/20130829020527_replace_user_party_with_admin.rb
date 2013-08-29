class ReplaceUserPartyWithAdmin < ActiveRecord::Migration
  def up
		add_column :users, :admin_id, :integer
		remove_column :users, :party_id
  end

  def down
		remove_column :users, :admin_id
		add_column :users, :party_id, :integer
  end
end
