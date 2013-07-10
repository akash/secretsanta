require 'spec_helper'

describe User do
	describe "receiver" do
		it 'should be generated from same party' do
			party = Party.create!(:name => "some party")
			party_user = User.create!(:email => "a@b.com", :user_name => "aaa", :password => "11111111", :password_confirmation => "11111111")
			another_party_user = User.create!(:email => "a@c.com", :user_name => "bbb", :password => "11111112", :password_confirmation => "11111112")
			party.users << party_user
			party.users << another_party_user

			party_user.get_receiver.should == another_party_user
		end

		it 'should not regenerate a receiver if already set' do
			another_party_user = User.create!(:email => "a@c.com", :user_name => "bbb", :password => "11111112", :password_confirmation => "11111112")
			party_user = User.create!(:email => "a@b.com", :user_name => "aaa", :password => "11111111", :password_confirmation => "11111111", :receiver => another_party_user)
			party_user.should_not_receive(:party)

			party_user.get_receiver.should == another_party_user
		end

		it 'should ensure that user does not get themselves' do
			party = Party.create!(:name => "some party")
			party_user = User.create!(:email => "a@b.com", :user_name => "aaa", :password => "11111111", :password_confirmation => "11111111")
			party.users << party_user

			party_user.get_receiver.should be_nil
		end

		it 'should ensure that user does not get excluded user' do
			party = Party.create!(:name => "some party")
			user = User.create!(:email => "a@b.com", :user_name => "aaa", :password => "11111111", :password_confirmation => "11111111")
			excluded_user = User.create!(:email => "a@c.com", :user_name => "aab", :password => "11111111", :password_confirmation => "11111111")
			party.users << user
			party.users << excluded_user
			user.excluded_users << excluded_user

			user.get_receiver.should be_nil
		end

		it 'should not delete the party when assigning a user' do
			party = Party.create!(:name => "some party")
			party_user = User.create!(:email => "a@b.com", :user_name => "aaa", :password => "11111111", :password_confirmation => "11111111")
			another_party_user = User.create!(:email => "a@c.com", :user_name => "bbb", :password => "11111112", :password_confirmation => "11111112")
			party.users << party_user
			party.users << another_party_user

			party_user.get_receiver.should == another_party_user
			party_user.reload.party == party
			another_party_user.reload.party == party
		end

		it 'should know if user has a secret santa assigned' do
			party = Party.create!(:name => "some party")
			receiver = User.create!(:email => "a@b.com", :user_name => "aaa", :password => "11111111", :password_confirmation => "11111111")
			secret_santa = User.create!(:email => "a@c.com", :user_name => "bbb", :password => "11111112", :password_confirmation => "11111112")
			party.users << receiver
			party.users << secret_santa
			user = secret_santa.get_receiver
			secret_santa.receiver_id = user.id
			secret_santa.save!

			receiver.has_secret_santa?.should be_true
			secret_santa.has_secret_santa?.should be_false
		end

		it 'should not allow the same user to be assigned to more than 1 user' do
			party = Party.create!(:name => "some party")
			user = User.create!(:email => "a@b.com", :user_name => "aaa", :password => "11111111", :password_confirmation => "11111111")
			user2 = User.create!(:email => "a@c.com", :user_name => "bbb", :password => "11111112", :password_confirmation => "11111112")
			user3 = User.create!(:email => "a@d.com", :user_name => "ccc", :password => "11111113", :password_confirmation => "11111113")
			party.users << user
			party.users << user2


			user.receiver_id = user.get_receiver.id
			user.save!
			user.receiver.should == user2
			user2.receiver_id = user2.get_receiver.id
			user2.save!
			user2.receiver.should == user

			party.users << user3
			user3.receiver.should be_nil
		end
	end
end