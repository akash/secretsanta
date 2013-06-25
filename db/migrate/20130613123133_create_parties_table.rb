class CreatePartiesTable < ActiveRecord::Migration
  def change
    create_table :parties do |table|
      table.string :name
      table.integer :admin_id
    end
  end
end
