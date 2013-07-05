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
	end
end