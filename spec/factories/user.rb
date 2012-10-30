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
end