class SessionsController < Devise::SessionsController

	def new
		@home_page = true
	end

end