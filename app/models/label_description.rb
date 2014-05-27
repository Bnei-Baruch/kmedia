#
# Description for a Label. I18n
#
#@author Edo.Shor
#
class LabelDescription < ActiveRecord::Base

  # --- Members ---

  belongs_to :label
  belongs_to :language, :foreign_key => :lang, :primary_key => :code3

  # --- Accessors ---

  attr_accessible :text, :lang

  scope :text_like, ->(pattern) { where('text like ?', "%#{pattern}%") }
end
