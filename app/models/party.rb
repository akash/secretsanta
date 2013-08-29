class Party < ActiveRecord::Base

  belongs_to :admin
  has_many :users
	after_create :randomise_id

  attr_accessible :name, :admin, :status, :id

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

	def reset
		self.status = STATUS[:pre_launch]
		users.all.each do |user|
			user.receiver = nil
			user.receiver_id = nil
			user.save
		end
		save
	end

	private
		def randomise_id
			self.id = Random.rand(99999)
		end

end