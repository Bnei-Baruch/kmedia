module LayoutAbilityHelper

  def columns_for_lesson_index()
    columns = 0
    columns += 1 if can?(:read, Lesson) # column for show action
    columns += 2 if can?(:edit_descriptions, Lesson) # column for edit/edit long description/transcripts lesson actions
    columns += 1 if can?(:destroy, Lesson) # column for destroy lesson action
    columns
  end

  def action_columns_for_index_page(klass)
    columns = 0
    columns += 1 if can?(:read, klass) # column for show action
    columns += 1 if can?(:update, klass) # column for edit action
    columns += 1 if can?(:destroy, klass) # column for destroy action
    columns
  end

  def display_actions_title(klass)
    colspan = action_columns_for_index_page(klass)
    engine = Haml::Engine.new <<-HAML
-if #{colspan} > 0
  %th{:colspan =>  #{colspan}} Actions
    HAML
    engine.render
  end

  def display_actions_title_for_lessons()
    colspan = columns_for_lesson_index
    engine = Haml::Engine.new <<-HAML
-if #{colspan} > 0
  %th{:colspan =>  #{colspan}} Actions
    HAML
    engine.render
  end
end