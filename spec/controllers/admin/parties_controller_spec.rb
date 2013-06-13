require "spec_helper"

describe Admin::PartiesController do

  it "should redirect to root when attempting to view a party that I don't have access to" do
    controller.stub!(:authenticate_admin!).and_return(true)
    controller.stub!(:current_admin).and_return("current admin")
    Party.should_receive(:find).with("1").and_return(mock(:admin => "not current admin"))

    get :show, :id => "1"

    response.should redirect_to admin_parties_path
  end

end