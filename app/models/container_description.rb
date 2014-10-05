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

  scope :by_lang, lambda {|lang| where(lang: lang)}

  before_save :flattern_desc

  private
  def flattern_desc
    write_attribute :container_desc_flat, self.container_desc.downcase if self.container_desc
    write_attribute :descr_flat, self.descr.downcase if self.descr
  end

end
