class Admin::PartiesController < Admin::AdminController

  def index
    @parties = Party.administered_by(current_admin).sort_by &:name
  end

  def new
    @party = Party.new
  end

  def create
    @party = Party.new params[:party]
    @party.admin = current_admin
    if @party.save
      redirect_to admin_parties_path, :flash => {:notice => "Party '#{@party.name}' successfully created"}
    else
      render :new
    end
  end

  def show
    @party = Party.find params[:id]
    redirect_to admin_parties_path unless @party.admin == current_admin
	end

	def launch
		party = Party.find params[:party_id]
		return redirect_to admin_path(:notice => "Hey hey, none of that! You can only launch a party that you started") unless party.admin == current_admin
		party.launch
		party.users.each {|user| UserMailer.delay.party_launched(party, user, root_url)}
		redirect_to admin_party_path(party), :notice => "Let's get this party started! Participants have been emailed informing them the party is now launched"
	end

	def reset
		party = Party.find params[:party_id]
		return redirect_to admin_path(:notice => "Hey hey, none of that! You can only reset a party that you started") unless party.admin == current_admin
		party.reset
		party.users.each {|user| UserMailer.delay.party_reset(party, user)}
		redirect_to admin_parties_path, :notice => "Your party has been reset. All members have been notified and will have to wait for you to relaunch the party before they can log in and pick their new names"
	end
end