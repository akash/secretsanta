class CreateTableExclusions < ActiveRecord::Migration
  def change
		create_table :exclusions do |t|
			t.integer :user_id
			t.integer :excluded_user_id
		end
	end
end
