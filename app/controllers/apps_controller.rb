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

  def review
    @all_apps = App.all
    authorize! :read, App.all
  end

  def castvote
    # get current users id, change has_voted? to true
    @user = User.find(current_user.id)
    if @user
      @user.update(has_voted: true)
      # get the app ID of the clicked vote
      app = App.find(params[:app_id])
      # increase vote count by 1
      app.increment!(:vote_count)
      redirect_to apps_review_path, notice: "Awesome, your vote has been cast!"
    else
      redirect_to apps_review_path, alert: "Uh oh, there was an error with your vote."
    end
  end

  def show

  end


  private

  def app_params
  	params.require(:app).permit(:user_id, :gpa, :current_position, :past_position, :sis_events, :achievement)
  end

end
