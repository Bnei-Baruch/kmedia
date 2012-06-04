module Admin::LessonsHelper
  def filtered_selected?
    @filter ? '' : 'active'
  end

  def show_all_selected?
    @filter == 'all' ? 'active' : ''
  end

  def secure_changed?
    @filter == 'secure_changed' ? 'active' : ''
  end
end
