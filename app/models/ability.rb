class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    if user.role? :super_admin
      can :manage, :all
    elsif user.role? :lesson_admin
      can :manage, [Lesson, Catalog, Asset]
    elsif user.role? :lesson_team
      can :manage, Lesson
      can :read, [Catalog, Asset]
    end

    if user.role? :admin
      can :see_timestamps, User
    elsif user.role? :normal
      can :see_timestamps, User, :id => user.id
    end

  end
end
