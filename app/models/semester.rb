class Semester < ActiveRecord::Base
  has_many :apps
 #  validate :vote_date

	# def vote_date
	# 	if vote_deadline > app_deadline
	# 	  errors.add(:vote_deadline, "Voting deadline cannot be older than Applicatoin deadline.")
	# 	end
	# end

end
