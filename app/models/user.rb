class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

         # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name

  has_and_belongs_to_many :roles, :uniq => true
  belongs_to :department

  has_many :lessons
  has_many :lessondesc_patterns
  has_many :catalogs
  has_many :file_assets
  has_many :virtual_lessons

  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end

  # Generate a token by looping and ensuring does not already exist.
  def generate_token(column = :reset_password_token)
    token = ''
    loop do
      token = SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz')
      break token unless User.where(column => token).first
    end
    update_attribute column, token
  end

end
