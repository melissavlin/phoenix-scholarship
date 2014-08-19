class Ability
  include CanCan::Ability

  def initialize(user)
    # Give users' with "Active" status ability to create a new application
 
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
    # can :read, :all if user.role == "Board"

    # can :manage, :chair if user.role == "Chair"
    # can :read, :all if user.role == "Chair"

    can :castvote, App if user.has_voted == false
    # can :access, App, :user_id => user.id


    # can :read, App, {:user_id => user.id}


    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
