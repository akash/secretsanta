class Party < ActiveRecord::Base

  belongs_to :admin
  has_many :users

  attr_accessible :name, :admin

  validates :name, :presence => true
  validates :name, :uniqueness => {:case_sensitive => false}

  scope :administered_by, lambda { |admin| where("admin_id = ?", admin.id) }

end