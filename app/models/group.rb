class Group < ActiveRecord::Base
  has_many :users

  attr_accessible :name

  validates :name, :presence => true, :uniqueness => {:case_sensitive => false}
end