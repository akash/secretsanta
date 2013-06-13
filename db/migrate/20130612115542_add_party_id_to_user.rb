class AddPartyIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :party_id, :integer
  end
end
