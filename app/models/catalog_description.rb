# == Schema Information
#
# Table name: catalog_descriptions
#
#  id         :integer          not null, primary key
#  catalog_id :integer          default(0), not null
#  name       :string(255)
#  lang       :string(3)
#  created_at :datetime
#  updated_at :datetime
#

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
