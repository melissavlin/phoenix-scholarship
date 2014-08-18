class DonationsController < ApplicationController
  # def index
  # end

  # def new
  # 	@donate = Donation.new
  # 	authorize! :manage, Donation
  # end

  def create
   @user = User.find(current_user.id)
   @donate = Donation.new(donate_params)
   @donate.user = User.find(current_user.id)
    if @donate.save
      # if user checks yes, change users' role to "Board"
      if params[:tag][:role] == "1"
        @donate.user.update(role: "Board")
      end
      redirect_to root_path, notice: "Thank you for your contribution!"
    else 
      redirect_to root_path, alert: "Please try again."
    end
  end

  private

  def donate_params
    params.require(:donation).permit(:user_id, :amt)
  end

  # def user_params
  #   params.require(:user).permit(:role)
  # end
end
