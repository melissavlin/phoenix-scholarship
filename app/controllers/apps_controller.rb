class AppsController < ApplicationController
	before_action :authenticate_user!
  def index
  	@apps = current_user.apps
  end

  def new
  	@app = App.new
    authorize! :create, App
  end

  def create
  	@user = User.find(current_user.id)
  	# @app.user = User.find(params[:user_id])
  	@app = App.new(app_params)
  	@app.user = User.find(current_user.id)
  	if @app.save
  		redirect_to user_apps_path(current_user), notice: "App submitted"
  	else
  		render :new
  	end
  end

  def show
  end


  private

  def app_params
  	params.require(:app).permit(:user_id, :gpa, :current_position, :past_position, :sis_events, :achievement)
  end

end
