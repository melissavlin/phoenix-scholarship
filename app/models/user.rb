class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  ROLES = %w[board chair]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :apps
  has_many :donations

  validates :nickname, :fname, :status, presence: true

  # email user groups
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
 	end

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    if !approved?
      :not_approved
    else
      super "Something went wrong."
    end
  end

end
