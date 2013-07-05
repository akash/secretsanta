class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	belongs_to :party
	belongs_to :receiver, :class_name => "User", :foreign_key => "reciver_id"
	has_many :exclusions
	has_many :excluded_users, :through => :exclusions

  attr_accessible :email, :user_name, :first_name, :last_name, :password, :password_confirmation, :remember_me, :receiver

	def get_receiver
		unless self.receiver
			all_party_users = party.users.reject{|user| user == self || self.excluded_users.include?(user)}
			self.receiver = all_party_users.sample
			save!
		end
		self.receiver
	end

	def full_name
		"#{first_name} #{last_name}"
	end

	def email_required?
		false
	end

	def email_changed?
		false
	end

end
