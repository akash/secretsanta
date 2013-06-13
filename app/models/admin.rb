class Admin < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :parties

  attr_accessible :user_name, :email, :password, :password_confirmation, :remember_me
end
