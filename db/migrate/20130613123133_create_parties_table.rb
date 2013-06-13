class CreatePartiesTable < ActiveRecord::Migration
  def change
    create_table :parties do |table|
      table.string :name
      table.string :admin_id
    end
  end
end
