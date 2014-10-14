# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  subject    :string(255)
#  comment    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  include Rakismet::Model

  attr_accessor :request_ip
  rakismet_attrs content: :comment, author: :subject, author_email: :email, user_ip: :request_ip
end
