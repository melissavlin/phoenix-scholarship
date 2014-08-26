class Ability
  include CanCan::Ability

  def initialize(user)
 
    if user.status == "Active"
        can :create, App
    elsif user.status == "Alumnus"
        can :manage, Donation
    end

    if user.role == "Chair"
        can :read, :all
        can :manage, :chair
    elsif user.role == "Board"
        can :read, :all
    end

    can :castvote, App if user.has_voted == false

  end
end
