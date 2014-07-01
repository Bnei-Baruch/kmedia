require 'progress_bar'

# Full list of models to reindex: [FileAsset, Catalog, CatalogDescription, Container, LessonDescription, LessondescPattern]
class ReindexAsset
  def self.container
    reindex([Container])
  end

  def self.reindex_all
    reindex([FileAsset, Catalog, CatalogDescription, Container, ContainerDescription, ContainerDescriptionPattern])
  end

  def self.reindex(sunspot_models)
    Dir.glob(Rails.root.join('app/models/**/*.rb')).each { |path| require path }

    reindex_options = {}
    reindex_options[:batch_commit] = false
    reindex_options[:batch_size] = 1000
    models = [sunspot_models].flatten
    total_documents = models.map { |m| m.count }.sum
    reindex_options[:progress_bar] = ProgressBar.new(total_documents)

    models.each { |model| model.solr_reindex reindex_options }
  end
end
