class AppsController < ApplicationController
	before_action :authenticate_user!
  
  def index
  	@apps = current_user.apps
  end

# past applications
  def archive
    authorize! :manage, :chair
    @archive = App.where(open: false)
  end

  def new
  	@app = App.new
    # @hello = "Hello!"
    authorize! :create, App
    #current scholarship semester
    @current_semester = Semester.last.created_at
    if @current_semester.month >=
      @scholarship_season = "Spring #{Date.today.year.next}"
    else
      @scholarship_season = "Fall #{Date.today.year}"
    end
    # @app.semester
    #   month = Date.today.month
    #   year = Date.today.year
    #   if month >= 8
    #     @app.semester = "Fall #{year}"
    #   elsif month <=4
    #     @app.semester = "Spring #{year}"
    #   end
  end

  def create
  	@user = User.find(current_user.id)
  	# @app.user = User.find(params[:user_id])
  	@app = App.new(app_params)
    @app.semester_id = Semester.last.id      
  	@app.user = User.find(current_user.id)
    if @app.save
  		redirect_to user_apps_path(current_user), notice: "App submitted"
  	else
  		render :new
  	end
  end

  def review
    @all_apps = App.where(open: true)
    authorize! :read, App.all

  end

  def castvote
    authorize! :castvote, App.all
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
      redirect_to apps_review_path, alert: "Uh oh, there was an problem getting your vote."
    end
  end

  def show
    # @user = User.find(params[current_user.id])
    @app = App.find(params[:id])
    authorize! :read, App

  end


  private

  def app_params
  	params.require(:app).permit(:user_id, :gpa, :current_position, :past_position, :sis_events, :achievement)
  end

end
