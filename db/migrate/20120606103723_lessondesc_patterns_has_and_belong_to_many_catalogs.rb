class LessondescPatternsHasAndBelongToManyCatalogs < ActiveRecord::Migration
  def change
    create_table :lessondesc_patterns_catalogs, :id => false do |t|
      t.references :lessondesc_pattern, :catalog
    end
  end
end
