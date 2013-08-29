class DropPartiesTable < ActiveRecord::Migration
  def up
		drop_table :parties
  end

  def down
		create_table :parties do |table|
			table.string :name
			table.integer :admin_id
		end
  end
end
