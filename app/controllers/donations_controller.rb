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
    check_board = params['role']
    if @donate.amt == nil
      redirect_to root_path, alert: "Please enter an amount."
      # check if checkbox is checked
    elsif @donate
      if check_board == "yes"
        if @donate.user.role == "Chair"
          @donate.save
          redirect_to root_path, notice: "Thank you for your contribution!"
        else
          @donate.save
          @donate.user.update(role: "Board")
          redirect_to root_path, notice: "Thank you for your contribution! You are now also a boardmember."
        end
      else
        @donate.save
        redirect_to root_path, notice: "Thank you for your contribution!"

      # redirect_to root_path, notice: "Thank you for your contribution! You are now also a boardmember."  
      end
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
