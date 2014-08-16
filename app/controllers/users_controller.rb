class UsersController < ApplicationController
  before_action :authenticate_user!
  # load_and_authorize_resource
	# before_action :set_user, only: [:show]

  def index
        # @user = User.find(current_user.id)
    # @user = User.find(params[:id])
    @app = App.new
    @all_apps = App.all
    @donate = Donation.new
    app_winner = App.order("vote_count").reverse_order.first
    @awardee = app_winner.user
  end

  def new

  end

  def edit
  end

  def roster
    @users = User.all

  end

  def show

  end

# the below views only the chairmember can see

  def chair
    authorize! :manage, :chair
    # document all donations
    @semester = Season.new(semester_params)
    @donations = Donation.order("created_at").reverse_order.all
  end

  def set_deadline


    redirect_to users_chair_path
  end
# start a new semester method
# set all (app.open = true) to false
# user with role:board, change to nil and has_voted to false
  def start_new_semester
    apps = App.all
    apps.each do |a|
      a.update(open: false)
    end
    users = User.where(role: "Board")
    users.each do |u|
      u.update(role: nil, has_voted: false)
    end
    redirect_to users_chair_path
  end

# post method when paid button is click: change donation.paid value to true
  def receive_donation
    donation = Donation.find(params[:donation_id])
    donation.update(paid: true)
    redirect_to users_chair_path
  end

  def getawardee
    app_winner = App.order("vote_count").reverse_order.first
    @awardee = app_winner.user
    redirect_to root_path
  end


  private

  def semester_params
    params.require(:season).permit(:semester, :app_deadline, :vote_deadline)
  end
  # def set_user
  # 	@user = User.find(params[:id])
  # end
end
