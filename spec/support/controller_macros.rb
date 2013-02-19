module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]

      @admin_attr = FactoryGirl.attributes_for(:admin)
      @admin_attr.merge!({email: "admin@example.com", password: "password"})
      user = User.create! @admin_attr
      user.roles.create(name: 'ArchiveAdmin')
      sign_in user
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]

      @user_attr = FactoryGirl.attributes_for(:user)
      @user_attr.merge!({email: "user@example.com", password: "password"})
      user = User.create! @user_attr
      user.roles.create(name: 'Operator')
      user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
      sign_in user
    end
  end
end