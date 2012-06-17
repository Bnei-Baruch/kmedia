#
# Description for a Dictionary. I18n
#
#@author Edo.Shor
#
class DictionaryDescription < ActiveRecord::Base

  # --- Members ---

  belongs_to :dictionary
  belongs_to :language, :foreign_key => :lang, :primary_key => :code3

  # --- Accessors ---

  attr_accessible :topic, :lang

end
