class DictionaryDescription < ActiveRecord::Base
  belongs_to :dictionary

  belongs_to :language, :foreign_key => :lang, :primary_key => :code3

  attr_accessible :topic, :lang
end
