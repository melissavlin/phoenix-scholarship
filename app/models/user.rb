class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  ROLES = %w[chair board]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :apps
  has_many :donations

  # validates_format_of :email, :with => /@/
  validates :nickname, :fname, :status, presence: true
end
