class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	belongs_to :party
	belongs_to :receiver, :class_name => "User", :foreign_key => "reciver_id"
	has_many :exclusions
	has_many :excluded_users, :through => :exclusions

  attr_accessible :email, :user_name, :password, :password_confirmation, :remember_me

	def get_receiver
		unless receiver
			all_party_users = party.users
			all_party_users.delete(self)
			receiver = all_party_users.sample
			save!
		end
		receiver
	end

end
