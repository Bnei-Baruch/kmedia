class Comment < ActiveRecord::Base
  include Rakismet::Model

  attr_accessor :request_ip
  rakismet_attrs content: :comment, author: :subject, author_email: :email, user_ip: :request_ip
end
