class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	belongs_to :admin
	belongs_to :receiver, :class_name => "User", :foreign_key => "receiver_id"
	has_many :exclusions
	has_many :excluded_users, :through => :exclusions

  attr_accessible :email, :user_name, :first_name, :last_name, :password, :password_confirmation, :remember_me, :receiver

	def get_receiver
		receiver || party.users.reject{|user| user == self || self.excluded_users.include?(user) || User.find(user.id).has_secret_santa?}.sample
	end

	def full_name
		"#{first_name} #{last_name}"
	end

	def has_secret_santa?
		User.exists? :receiver_id => self.id
	end

	def email_required?
		false
	end

	def email_changed?
		false
	end

end
