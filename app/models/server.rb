# == Schema Information
#
# Table name: servers
#
#  servername :string(30)       default(""), not null, primary key
#  httpurl    :string(255)
#  created    :datetime
#  updated    :datetime
#  lastuser   :string(16)
#  path       :string(255)
#  id         :integer          not null
#

class Server < ActiveRecord::Base
  self.primary_key = :servername
  has_many :file_assets, :foreign_key => :servername, :primary_key => :servername

  # code3 => locale
  NAME_URL = {}
  Server.all.map{|l| NAME_URL[l.servername] = l.httpurl}
  NAME_URL.freeze

  def to_s
    servername
  end
end
