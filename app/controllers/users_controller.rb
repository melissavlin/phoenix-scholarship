require 'mandrill'
class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @app = App.new
    @all_apps = App.all
    @donate = Donation.new
    @semester = Semester.last
    @date = Date.today
    # validate app deadline
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
    # disable app review if vote deadline has past
    vote_deadline = Semester.last.vote_deadline
    if vote_deadline != nil
      @voting_closed = Date.today >= vote_deadline
    end
    # @last_awardee = App.where(award:true).last.user.fname

    # DISABLED UNTIL NEXT SEMESTER
    # last_semester = Semester.all[-2]
    # if last_semester.app_deadline.month >= 8
    #   @last_scholarship_season = "Spring #{last_semester.app_deadline.year} Scholarship"
    # else
    #   @last_scholarship_season = "Fall #{last_semester.app_deadline.year} Scholarship"
    # end

    # authorize! :manage, :chair
    @semester = Semester.new
    @current_semester = Semester.last
    if @current_semester.app_deadline == nil
      @scholarship_season = "Scholarship Pending" 
    elsif @current_semester.app_deadline.month >= 8
      @scholarship_season = "Spring #{Date.today.year.next} Scholarship"
    else
      @scholarship_season = "Fall #{Date.today.year} Scholarship"
    end
    # applicants section
    @open_apps = App.where(open: true).order("vote_count").reverse_order
    if @current_semester.vote_deadline != nil
      @check_vote_deadline = Date.today > Semester.last.vote_deadline
    end
    # donation history section
    @donations = Donation.all.reverse_order

    # unapproved accounts
    @unapproved_users = User.where(approved:false)
  end

  def roster
    @users = User.all

  end


  def show

  end

# the below views only the chairmember can see
  def chair

  end

  def approve_user
    user = User.find(params[:id])
    if user.update(approved:true)
      redirect_to users_chair_path
    else
      render :chair, alert: "Could not approve new account. Please try again."
    end
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

  def declare_awardee
    # auto start a new semester
    @semester = Semester.new #(semester_params)
    if @semester.save
      # declare the applicant with most votes as awardee
      open_apps = App.where(open: true)
      app_awardee = open_apps.order("vote_count").reverse_order.first
      app_awardee.update(award:true)
      # close the status of all open apps
      open_apps.each do |a|
        a.update(open: false)
      end
      # remove the role of boardmember from all users
      users = User.where(role: "Board")
      users.each do |u|
        u.update(role: nil, has_voted: false)
      end
      redirect_to users_chair_path
    else
      redirect_to users_chair_path, alert: "There was a problem declaring an award winner."  
    end
  end

# post method when paid button is click
  def receive_donation
    donation = Donation.find(params[:donation_id])
    if donation.update(paid: true)
      respond_to do |format|
        format.html {redirect_to users_chair_path, notice: "donation received"}
        format.js {head :no_content}
      end
    # redirect_to users_chair_path
    end
  end

# mandrill-api, send a new message
  def send_msg_to_actives
    subject = params['subject']
    msg = params['msg']
    recipient = params['rcpt']
    m = Mandrill::API.new
    message = { 
    :subject=> subject, 
    # change to use the email from the user.role = Chair
    :from_name=> "Name",
    :from_email=>"from@me.com",
    :to=>User.to_mandrill_to(recipient), 
    :html=>"<html><body style='font-family:Arial;font-size:20px'> #{msg}</html>", 
    # :merge_vars => User.to_mandrill_merge_vars(User.active),
    :preserve_recipients => false
    } 
    sending = m.messages.send message
    redirect_to users_chair_path, notice: "email sent"
  end



  private

  def semester_params
    params.require(:semester).permit(:year, :season, :app_deadline, :vote_deadline)
  end

end
