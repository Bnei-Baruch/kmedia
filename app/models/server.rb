class Server < ActiveRecord::Base
  has_many :assets, :foreign_key => :servername, :primary_key => :servername
end
