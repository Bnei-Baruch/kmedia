class Server < ActiveRecord::Base
  has_many :file_assets, :foreign_key => :servername, :primary_key => :servername

  def to_s
    servername
  end
end
