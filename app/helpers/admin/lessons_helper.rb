module Admin::LessonsHelper
  def filtered_selected?
    @filter ? '' : 'selected'
  end

  def show_all_selected?
    @filter == 'all' ? 'selected' : ''
  end
end
