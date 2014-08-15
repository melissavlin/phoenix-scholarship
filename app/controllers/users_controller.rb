class UsersController < ApplicationController
  before_action :authenticate_user!
  # load_and_authorize_resource
	# before_action :set_user, only: [:show]

  def index
  end

  def new

  end

  def edit
  end

  def show
    # @user = User.find(current_user.id)
    # @user = User.find(params[:id])
    @app = App.new
    @all_apps = App.all
    @donate = Donation.new

    app_winner = App.order("vote_count").reverse_order.first
    @awardee = app_winner.user
  end

# the view that only the chairperson can see
  def chair
    authorize! :manage, :chair
    @donations = Donation.order("created_at").reverse_order.all
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
    redirect_to user_path(current_user)
  end

  def roster
    @users = User.all

  end

  private

  # def set_user
  # 	@user = User.find(params[:id])
  # end
end
