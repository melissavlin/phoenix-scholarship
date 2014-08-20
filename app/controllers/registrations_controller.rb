class RegistrationsController < Devise::RegistrationsController
	before_filter :authenticate_user!, :except => [:new]

	def edit
	  	@donation = current_user.donations
	  	# authorize! :manage, Donation
	end

protected

  def after_update_path_for(resource)
  		root_path
  end

end