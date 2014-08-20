class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  ROLES = %w[board chair]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :apps
  has_many :donations

  # validates_format_of :email, :with => /@/
  validates :nickname, :fname, :status, presence: true

  # for email
  scope :active, -> {where(status: "Active")}
  scope :alumnae, -> {where(status: "Alumnus")}
  scope :board, -> {where(role: "Board")}

  def self.to_mandrill_to(users)
    if users == "active"
  	  User.active.map{|user| {:name => user.fname, :email => user.email}}
    elsif users == "alumnus"
      User.alumnae.map{|user| {:name => user.fname, :email => user.email}}
    elsif users == "board"
      User.board.map{|user| {:name => user.fname, :email => user.email}}
    elsif users == "all"
      User.all.map{|user| {:name => user.fname, :email => user.email}}
    end
    # outputs array of hashes [{:email => "email"}, ...]
	 # users.map{|user| {:name => user.fname, :email => user.email}}
	 # outputs array of emails only ["email", "email"]
 		# users.map{|user| user.email }
	end

	# def self.to_mandrill_merge_vars(users)
	# 	users.map{|user| {:rcpt => user.email, :vars => [{:name => 'first_name', :content => user.fname}]}}
	# end
end
