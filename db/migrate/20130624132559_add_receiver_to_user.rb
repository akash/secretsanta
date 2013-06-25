class AddReceiverToUser < ActiveRecord::Migration
  def change
		add_column :users, :receiver_id, :integer
  end
end
