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
      cannot :destroy, Lesson
      cannot :destroy, Catalog
      cannot :destroy, Asset
      cannot :update, User
      cannot :delete, User
    elsif user.role? :operator
      #- Operator - Can edit lessons. Can not Create anything new
      can :update, Lesson
      can :edit_descriptions, Lesson
      can :edit_all_lesson_fields, Lesson
    elsif user.role? :content_manager
      #- Content manager - Can edit descriptions only (in lesson edit)
      can :update, Lesson
      can :edit_descriptions, Lesson
      cannot :edit_all_lesson_fields, Lesson
    end

  end
end
