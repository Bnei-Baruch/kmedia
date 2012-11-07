FactoryGirl.define do
  factory :user, class: User do
    first_name "John"
    last_name  "Doe"
  end

  # This will use the User class (Admin would have been guessed)
  factory :admin, class: User do
    first_name "Admin"
    last_name  "User"
  end

  #factory :user do
  #  name 'Test User'
  #  email 'example@example.com'
  #  password 'please'
  #  password_confirmation 'please'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now

    # USAGE:
    # @user = FactoryGirl.create(:user)
    # sign_in @user
  #end

end