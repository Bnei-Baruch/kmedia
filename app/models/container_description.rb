# == Schema Information
#
# Table name: container_descriptions
#
#  id                  :integer          not null, primary key
#  container_id        :integer          default(0), not null
#  container_desc      :string(255)
#  lang                :string(3)
#  created_at          :datetime
#  updated_at          :datetime
#  descr               :text
#  container_desc_flat :string(255)
#  descr_flat          :text
#

class ContainerDescription < ActiveRecord::Base
  belongs_to :container, touch: :updated_at

  belongs_to :language, foreign_key: :lang, primary_key: :code3

  searchable do
    text :descr, as: :kmedia
    text :container_desc, as: :kmedia do
      container_desc.nil? ? '' : container_desc.gsub!(/[^[:print:]]/i, '')
    end

    boolean :for_censorship do
      false
    end
    boolean :closed_by_censor do
      false
    end
  end

  scope :by_lang, lambda {|lang| where(:lang => lang)}
end
