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
    @donate = Donation.new
  end

  private

  # def set_user
  # 	@user = User.find(params[:id])
  # end
end
