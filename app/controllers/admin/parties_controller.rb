class Admin::PartiesController < Admin::AdminController

  def index
    @parties = Party.administered_by current_admin
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
		return redirect_to admin_path(:notice => "You can only launch A party that you started") unless party.admin == current_admin
		party.launch
		redirect_to admin_party_path(party)
	end
end