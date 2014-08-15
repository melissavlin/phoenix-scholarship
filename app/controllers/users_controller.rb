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
    @user = User.find(current_user.id)
    @app = App.new
    @all_apps = App.all
    @donate = Donation.new

    app_winner = App.order("vote_count").reverse_order.first
    @awardee = app_winner.user
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
