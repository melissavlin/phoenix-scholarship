class RegistrationsController < Devise::RegistrationsController

	def edit
	  	@donation = current_user.donations.reverse_order
	  	# authorize! :manage, Donation
	end


protected

  def after_update_path_for(resource)
  		# root_path
  		# user_path(resource)
  		edit_user_registration_path
  end

 def after_sign_up_path_for(resource)
      new_user_registration_path
  end

	def after_inactive_sign_up_path_for(resource)
	  new_user_registration_path
	end
end