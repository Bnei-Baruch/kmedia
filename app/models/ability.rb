class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    # Roles:
    if user.role? :super_admin
      #- Super Admin - Can do everything
      can :manage, :all
    elsif user.role? :archive_admin
      #- Archive Admin - Can do everything except deleting file_assets and permissions management
      can :manage, :all
      cannot :manage, User
      can :read, User
      can :merge, Lesson
      can :send_to_censor, Lesson
      cannot :destroy, [Lesson, Catalog, FileAsset]
      can [:assignable, :manage], Label
    elsif user.role? :operator
      #- Operator - Can edit lessons. Can Create new container
      can [:read, :create, :update, :edit_descriptions, :edit_all_lesson_fields], Lesson
      can :read, Catalog
      can :send_to_censor, Lesson
      #- handling the lessons with changed security or with no files
      cannot :special_admin_features, [Lesson, Catalog]
      can [:assignable, :manage], Label
    elsif user.role? :content_manager
      #- Content manager - Can edit long/short descriptions and transcripts
      can [:read, :update, :edit_descriptions], Lesson
      cannot :edit_all_lesson_fields, Lesson
      #- handling the lessons with changed security or with no files
      cannot :special_admin_features, [Lesson, Catalog]
    elsif user.role? :PSearchUser
      can :search_secure, :all
    elsif user.role? :censor
      can :censorship, :Lesson
    else # Guest
    end

  end
end
