class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    # Roles:
    if user.role? :super_admin
      #- Super Admin - Can do everything
      can :manage, :users
      can :manage, :all
    elsif user.role? :archive_admin
      #- Archive Admin - Can do everything except deleting file_assets and permissions management
      can :manage, :all
      cannot :manage, :users
      can :merge, Lesson
      cannot :destroy, Lesson
      cannot :destroy, Catalog
      cannot :destroy, FileAsset
      cannot :update, User
      cannot :delete, User
    elsif user.role? :operator
      #- Operator - Can edit lessons. Can Create new container
      can :update, Lesson
      can :create, Lesson
      can :edit_descriptions, Lesson
      can :edit_all_lesson_fields, Lesson
      can :read, Catalog
      #- Operator - Can't edit the "secure_changed" field, it is updated automatically when the "secure" field changed
      cannot :edit_secure_changed_field, Lesson
    elsif user.role? :content_manager
      #- Content manager - Can edit descriptions only (in lesson edit)
      can :update, Lesson
      can :edit_descriptions, Lesson
      cannot :edit_all_lesson_fields, Lesson
      #- Operator - Can't edit the "secure_changed" field, it is updated automatically when the "secure" field changed
      cannot :edit_secure_changed_field, Lesson
    elsif user.role? :PSearchUser
      can :search_secure, :all
    else # Guest
    end

  end
end
