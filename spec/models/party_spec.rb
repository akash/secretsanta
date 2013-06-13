require 'spec_helper'

describe Party do

  it 'should be valid when all attributes are passed' do
    party = Party.new(:name => "party name")
    party.should be_valid
  end

  it 'should not be valid when name is missing' do
    party = Party.new(:name => nil)
    party.should_not be_valid
    party.errors[:name].should == ["can't be blank"]
  end

  it 'should not be valid when name is not unique' do
    Party.create!(:name => "party name")
    duplicate = Party.new(:name => "party name")
    duplicate.should_not be_valid
    duplicate.errors[:name].should == ["has already been taken"]
  end

  it 'should not care about case when checking if a name is unique' do
    Party.create!(:name => "party name")
    duplicate = Party.new(:name => "party Name")
    duplicate.should_not be_valid
    duplicate.errors[:name].should == ["has already been taken"]
  end


  describe "administered_by" do
    it 'should return all parties that are administered by given admin' do
      admin = Admin.create! :user_name => "admin", :email => "admin@admin.com", :password => "password", :password_confirmation => "password"
      another_admin = Admin.create! :user_name => "another", :email => "another@admin.com", :password => "password", :password_confirmation => "password"
      party = Party.create! :name => "expected", :admin => admin
      another_party = Party.create! :name => "another", :admin => another_admin

      parties = Party.administered_by(admin)
      parties.should == [party]
    end
  end

end