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
    @semester = Semester.last
    # hide board member question if current user is a board member
  end

  def roster
    @users = User.all

  end

  def show

  end

# the below views only the chairmember can see

  def chair
    authorize! :manage, :chair
    @semester = Semester.new
    @current_semester = Semester.last
    if @current_semester.app_deadline == nil
      @scholarship_season = "No deadline is set yet." 
    elsif @current_semester.app_deadline.month >= 8
      @scholarship_season = "Spring #{Date.today.year.next} Scholarship"
    else
      @scholarship_season = "Fall #{Date.today.year} Scholarship"
    end

    # applicants section
    @open_apps = App.where(open: true).order("vote_count").reverse_order
    @check_vote_deadline = Date.today > Semester.last.vote_deadline

      # app_winner = App.order("vote_count").reverse_order.first
      # @awardee = app_winner.user
    # end

    # donation history section
    @donations = Donation.order("created_at").reverse_order.all
  end

  # update last semester
  def set_deadline
    semester = Semester.last
      if semester.update(semester_params)
        redirect_to users_chair_path, notice: "New deadlines set."
      else 
        render :chair, alert: "There was a problem setting the deadlines. Please try again."
      end
  end

# declare scholarship recipient, which will trigger the following:
# out of all the current apps (with open status), get app with most votes and change award attr to true
# create new semester
# set all apps with open status to false
# user with role:board, change to nil and has_voted to false
  def declare_awardee
    apps = App.where(open: true)

    apps.each do |a|
      a.update(open: false)
    end
    users = User.where(role: "Board")
    users.each do |u|
      u.update(role: nil, has_voted: false)
    end
    semester = Semester.new(semester_params)
    semester.save
    redirect_to users_chair_path
  end

# post method when paid button is click
# change donation.paid value to true
  def receive_donation
    donation = Donation.find(params[:donation_id])
    donation.update(paid: true)
    redirect_to users_chair_path
  end


  private

  def semester_params
    params.require(:semester).permit(:year, :season, :app_deadline, :vote_deadline)
  end

  # def set_user
  # 	@user = User.find(params[:id])
  # end
end
