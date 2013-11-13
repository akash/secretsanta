class Admin < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

	has_many :users
	after_create :randomise_id

	attr_accessible :user_name, :email, :password, :password_confirmation, :remember_me, :unconfirmed_email, :status, :id

	validates :user_name, :presence => {:message => "Party Name is required"}

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
