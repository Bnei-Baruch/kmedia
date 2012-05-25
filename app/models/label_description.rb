class LabelDescription < ActiveRecord::Base
  belongs_to :label
  belongs_to :language, :foreign_key => :lang, :primary_key => :code3

  attr_accessible :text, :lang
end
