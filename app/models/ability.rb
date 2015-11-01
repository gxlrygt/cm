class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.is_a?(AdminUser)
      can :manage, :all
    end
  end
 end