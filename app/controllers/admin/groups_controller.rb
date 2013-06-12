class Admin::GroupsController < ApplicationController

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new params[:group]
    if @group.save
      redirect_to admin_groups, :flash => {:notice => "Group '#{@group.name}' successfully created"}
    else
      render :new
    end
  end
end