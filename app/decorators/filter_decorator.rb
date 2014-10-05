class FilterDecorator
  attr_accessor :filter

  def initialize(filter)
    @filter = filter
  end

  def filtered_selected?
    @filter ? '' : 'active'
  end

  def show_all_selected?
    @filter == 'all' ? 'active' : ''
  end

  def secure_changed?
    @filter == 'secure_changed' ? 'active' : ''
  end

  def no_files?
    @filter == 'no_files' ? 'active' : ''
  end

  def lost?
    @filter == 'lost' ? 'active' : ''
  end

  def by_security?
    @filter == 'by_security' ? 'active' : ''
  end

  def for_censorship?
    @filter == 'for_censorship' ? 'active' : ''
  end

end
