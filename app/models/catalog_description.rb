class CatalogDescription < ActiveRecord::Base

  belongs_to :catalog
  belongs_to :language, foreign_key: :lang, primary_key: :code3

  searchable do
    text :name, as: :kmedia

    boolean :for_censorship do
      false
    end
    boolean :closed_by_censor do
      false
    end
  end

end
