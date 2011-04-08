class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    # Roles:
    if user.role? :super_admin
      #- Super Admin - Can do everything
      can :manage, :all
    elsif user.role? :archive_admin
      #- Archive Admin - Can do everything except deleting files and permissions management
      can :manage, :all
      cannot :delete, Asset
      cannot :edit, Role
    elsif user.role? :operator
      #- Operator - Can edit lessons. Can not Create anything new
      can :edit, Lesson
    elsif user.role? :content_manager
      #- Content manager - Can edit descriptions only (in lesson edit)
      can :edit_descriptions, Lesson
    end

  end
end
