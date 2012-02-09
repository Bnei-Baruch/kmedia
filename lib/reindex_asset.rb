require 'progress_bar'

class ReindexAsset
  def self.lesson
    klass = Lesson
    reindex([Lesson])
  end

  def self.reindex(sunspot_models)
    Dir.glob(Rails.root.join('app/models/**/*.rb')).each { |path| require path }

    reindex_options = {:batch_commit => false}
    reindex_options[:batch_size] = 1000
    total_documents = sunspot_models.map { |m| m.count }.sum
    reindex_options[:progress_bar] = ProgressBar.new(total_documents)

    sunspot_models.each { |model|
      model.solr_reindex (reindex_options)
    }
  end
end
