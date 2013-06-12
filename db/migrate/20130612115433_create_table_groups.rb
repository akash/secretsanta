class CreateTableGroups < ActiveRecord::Migration
  def change
    create_table :groups do |table|
      table.string :name
    end
  end
end
