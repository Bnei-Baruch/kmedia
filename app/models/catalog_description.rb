class CatalogDescription < ActiveRecord::Base
  self.table_name = :catnodedesc
  self.primary_key = :catnodedescid

  belongs_to :catalog, :foreign_key => :catalognodeid
  belongs_to :language, :foreign_key => :lang, :primary_key => :code3

  before_create :create_timestamps
  before_update :update_timestamps

  searchable do
    text :catalognodename, as: :kmedia

    boolean :for_censorship do
      false
    end
    boolean :closed_by_censor do
      false
    end
  end

  def create_timestamps
    write_attribute :created, Time.now
    write_attribute :updated, Time.now
  end

  def update_timestamps
    write_attribute :updated, Time.now
  end

  def self.find_by_id(*args, &block)
    self.send(:find_by_catalogdescid, *args, &block)
  end

end
