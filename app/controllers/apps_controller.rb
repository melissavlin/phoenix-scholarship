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
    authorize! :create, App
    @current_semester = Semester.last.app_deadline
    if @current_semester != nil
      if @current_semester.month >= 8
        @scholarship_season = "Spring #{Date.today.year.next}"
      else
        @scholarship_season = "Fall #{Date.today.year}"
      end
    end
    
    app_deadline = Semester.last.app_deadline
    if app_deadline != nil
      @app_deadline_past= Date.today >= app_deadline
    end
    # check if current user submitted an app already, get all apps where open = true
    if current_user.status == "Active"
      open_apps = App.where(open:true)
      @user_id = User.find(current_user.id).id
      if open_apps.find_by(user_id:@user_id)
        @already_applied = open_apps.find_by(user_id:@user_id).user_id
      end
    end
  end

  def create
  	@user = User.find(current_user.id)
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
    @vote_deadline = Semester.last.vote_deadline
    if @vote_deadline != nil
      @no_voting = Date.today <= @vote_deadline
    end
    authorize! :read, App.all
  end

  def castvote
    authorize! :castvote, App
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
    @app = App.find(params[:id])
    # @own_apps = App.where(user_id: current_user.id)
    # authorize! :read, App
  end

  def previewapp
  end

  private

  def app_params
  	params.require(:app).permit(:user_id, :gpa, :current_position, :past_position, :sis_events, :achievement, :semester_active, :semester_inactive, :major, :minor, :credit_count, :academic_probation, :post_grad_goal, :position_accomplishment, :sis_event_planning, :org_improvement, :com_service_attended, :com_service_planning, :other_org_membership, :workshop_attended, :workshop_planning, :cv)
  end

end
