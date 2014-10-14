# == Schema Information
#
# Table name: dictionary_descriptions
#
#  id            :integer          not null, primary key
#  dictionary_id :integer
#  topic         :string(255)
#  lang          :string(3)        default("HEB")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

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
