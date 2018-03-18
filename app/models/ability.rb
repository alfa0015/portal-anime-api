class Ability
  include CanCan::Ability

  def initialize(current_user)

    current_user ||= User.new # guest user (not logged in)
    if current_user.has_role? :webmaster
      can :manage, :all
    else
      can :read, :all
    end

  end
end
