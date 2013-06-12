require 'spec_helper'

describe Group do

  it 'should be valid when all attributes are passed' do
    group = Group.new(:name => "group name")
    group.should be_valid
  end

  it 'should not be valid when name is missing' do
    group = Group.new(:name => nil)
    group.should_not be_valid
    group.errors[:name].should == ["can't be blank"]
  end

  it 'should not be valid when name is not unique' do
    Group.create!(:name => "group name")
    duplicate = Group.new(:name => "group name")
    duplicate.should_not be_valid
    duplicate.errors[:name].should == ["has already been taken"]
  end

  it 'should not care about case when checking if a name is unique' do
    Group.create!(:name => "group name")
    duplicate = Group.new(:name => "Group Name")
    duplicate.should_not be_valid
    duplicate.errors[:name].should == ["has already been taken"]
  end


end