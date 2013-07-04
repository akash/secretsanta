class Party < ActiveRecord::Base

  belongs_to :admin
  has_many :users

  attr_accessible :name, :admin, :status

  validates :name, :presence => true
  validates :name, :uniqueness => {:case_sensitive => false}

  scope :administered_by, lambda { |admin| where("admin_id = ?", admin.id) }

	STATUS = {:pre_launch => "Pre Launch", :launched => "launched"}

	def launched?
		status == STATUS[:launched]
	end

	def launch
		self.status = STATUS[:launched]
		save
	end

end