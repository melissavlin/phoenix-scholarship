class RegistrationsController < Devise::RegistrationsController

	def edit
	  	@donation = current_user.donations
	  	# authorize! :manage, Donation
	end

protected

  def after_update_path_for(resource)
  		root_path
  end

end