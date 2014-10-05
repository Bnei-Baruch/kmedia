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
      can :merge, Container
      can :send_to_censor, Container
      cannot :destroy, [Container, Catalog, FileAsset]
      can [:assignable, :manage], Label
    elsif user.role? :operator
      #- Operator - Can edit containers. Can Create new container
      can [:read, :create, :update, :edit_descriptions, :edit_all_lesson_fields], Container
      can :read, Catalog
      can :send_to_censor, Container
      #- handling the containers with changed security or with no files
      cannot :special_admin_features, [Container, Catalog]
      can [:assignable, :manage], Label
    elsif user.role? :content_manager
      #- Content manager - Can edit long/short descriptions and transcripts
      can [:read, :update, :edit_descriptions], Container
      cannot :edit_all_lesson_fields, Container
      #- handling the containers with changed security or with no files
      cannot :special_admin_features, [Container, Catalog]
    elsif user.role? :PSearchUser
      can :search_secure, :all
    elsif user.role? :censor
      can :censorship, :Container
    else # Guest
    end

  end
end
