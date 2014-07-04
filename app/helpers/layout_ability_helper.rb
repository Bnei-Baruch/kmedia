module LayoutAbilityHelper

  def columns_for_container_index()
    columns = 0
    columns += 1 if can?(:read, Container) # column for show action
    columns += 2 if can?(:edit_descriptions, Container) # column for edit/edit long description/transcripts container actions
    columns += 1 if can?(:destroy, Container) # column for destroy container action
    columns += 1 if can?(:send_to_censor, Container) # column to mark for censorship container action
    columns
  end

  def action_columns_for_index_page(klass)
    columns = 0
    columns += 1 if can?(:read, klass) # column for show action
    columns += 1 if can?(:update, klass) # column for edit action
    columns += 1 if can?(:destroy, klass) # column for destroy action
    columns += 1 if can?(:send_to_censor, Container) # column for destroy container action
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

  def display_actions_title_for_containers()
    colspan = columns_for_container_index
    engine = Haml::Engine.new <<-HAML
-if #{colspan} > 0
  %th{:colspan =>  #{colspan}} Actions
    HAML
    engine.render
  end
end
