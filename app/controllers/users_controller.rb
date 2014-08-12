class UsersController < ApplicationController
  before_action :authenticate_user!
	# before_action :set_user, only: [:show]

  def index
  end

  def new
  end

  def edit
  end

  def show
    @user = User.find(current_user.id)

  end

  private

  # def set_user
  # 	@user = User.find(params[:id])
  # end
end
