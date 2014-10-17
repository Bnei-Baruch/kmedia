# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(128)      default(""), not null
#  reset_password_token   :string(255)
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string(255)      default("")
#  last_name              :string(255)      default("")
#  authentication_token   :string(255)
#  reset_password_sent_at :datetime
#  department_id          :integer
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

         # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name

  has_and_belongs_to_many :roles, uniq: true
  belongs_to :department

  has_many :containers
  has_many :container_description_patterns
  has_many :catalogs
  has_many :file_assets
  has_many :virtual_lessons

  def role?(role)
    !!self.roles.find_by_name(role.to_s.camelize)
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
