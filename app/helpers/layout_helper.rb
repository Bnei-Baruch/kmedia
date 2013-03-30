# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module LayoutHelper
  def stylesheet(*args)
    content_for(:stylesheets) { stylesheet_link_tag(*args) }
  end

  def javascript(*args)
    content_for(:javascripts) { javascript_include_tag(*args) }
  end

  def display_descriptions(f, descriptions, source, target)
    engine = Haml::Engine.new <<-HAML
- counter = 0
= form.simple_fields_for :#{source}, descriptions do |descr_f|
  - language = descr_f.object.language
  - if counter == 0
    <div class="row">
  - if counter < 3 # 3 separate columns
    .span4
      = descr_f.input :lang, :as => :hidden
      = descr_f.input :#{target}, :as => :text, :label => language.to_s, :input_html => { :class => language.code3.downcase, :rows => 3 }
  - if counter == 3
    </div>
    .accordion-heading
      %a.accordion-toggle(data-toggle="collapse" href="#other-languages") Other Languages
    <div id="other-languages" class="collapse">
  - if counter >= 3
    - if counter % 3 == 0
      <div class="row">
    .span4
      = descr_f.input :lang, :as => :hidden
      = descr_f.input :#{target}, :as => :text, :label => language.to_s, :input_html => { :class => language.code3.downcase, :rows => 3 }
    - if counter % 3 == 2
      </div>
  - counter += 1
</div>
    HAML
    engine.render self, :form => f, :descriptions => descriptions
  end

  def display_errors(f)
    engine = Haml::Engine.new <<-HAML
- if form.error_notification
  .alert.alert-error.fade.in
    %a.close(data-dismiss="alert" href="#") &times;
    = form.error_notification :class => 'no-margin'
  %hr.soften
    HAML
    engine.render self, :form => f
  end

  def display_actions(f, location)
    engine = Haml::Engine.new <<-HAML
.actions
  %button.btn.btn-primary.btn-large{:type => 'submit', :'data-disable-with' => 'Please wait...'} Update
  %button.btn.btn-large{:onclick => "location.href='#{location}'; return false;", :type => 'button'} Cancel
    HAML
    engine.render self, :form => f
  end

  def display_actions_with_mark(f, location)
    engine = Haml::Engine.new <<-HAML
.actions
  %button.btn.btn-primary.btn-large{:type => 'submit', :'data-disable-with' => 'Please wait...'} Update
  %button.btn.btn-large{:onclick => "location.href='#{location}'; return false;", :type => 'button'} Cancel
  - if @lesson.lessonid && can?(:merge, @lesson)
    .merge.pull-right
      %button.mark_for_merge.btn{:onclick => "mark_me(this); return false;", :'data-mark-path' => mark_for_merge_admin_lesson_path(@lesson), :class => @lesson.marked_for_merge ? 'btn-warning' : '', :type => 'button'}
        = @lesson.marked_for_merge ? "Unmark" : "Mark"
      %button.btn.btn-danger{:onclick => "merge_to_me_get_list(this); return false;", :'data-merge-path' => merge_get_list_admin_lesson_path(@lesson)}= 'Merge Preview'
    HAML
    engine.render self, :form => f
  end

  def display_show_item(name, value, as_is = false)
    engine = Haml::Engine.new <<-HAML
%p
  %strong #{name.humanize}:
  #{as_is ? value : value.to_s.gsub(/\s/, '&nbsp;')}
    HAML
    engine.render
  end

  def display_secure(secure_level)
    security = SECURITY.select { |s| s[:level] == secure_level }
    name = security.first[:name].downcase
    klass = security.first[:klass]
    name == 'unsecure' ? 'non-secure' : "<span class='label label-#{klass}'>#{name.humanize}</span>".html_safe
  end

  def convert_seconds_to_human_readable(duration)
    x = duration.to_i
    return 'N/A' if x == 0

    seconds = x % 60
    x /= 60
    minutes = x % 60
    x /= 60
    hours = x % 24
    x /= 24
    days = x

    return "#{'%02x' % days} #{'%02x' % hours}:#{'%02x' % minutes}:#{'%02x' % seconds}" if days > 0
    return "#{'%02x' % hours}:#{'%02x' % minutes}:#{'%02x' % seconds}"
  end

  def display_visibility(visibility)
    visibility ? 'Visible' : 'Hidden'
  end

  def display_catalog_state(state)
    state ? 'Open' : 'Closed'
  end

  def display_transcripts(f, transcripts, source, target)
    engine = Haml::Engine.new <<-HAML
- counter = 0
= form.simple_fields_for :#{source}, transcripts do |transcript_f|
  - language = transcript_f.object.language
  - if counter == 0
    <div class="row">
  - if counter < 3 # 3 separate columns
    .span4
      = transcript_f.input :lang, :as => :hidden
      = transcript_f.input :#{target}, :as => :ckeditor, :label => language.to_s, :input_html => {:namespace => "transcript", :toolbar=>"Plus", :class => language.code3.downcase}
  - if counter == 3
    </div>
    .accordion-heading
      %a.accordion-toggle(data-toggle="collapse" href="#other-languages") Other Languages
    <div id="other-languages" class="collapse">
  - if counter >= 3
    - if counter % 3 == 0
      <div class="row">
    .span4
      = transcript_f.input :lang, :as => :hidden
      = transcript_f.input :#{target}, :as => :ckeditor, :label => language.to_s, :input_html => {:namespace => "transcript", :toolbar=>"Plus", :class => language.code3.downcase}
    - if counter % 3 == 2
      </div>
  - counter += 1
</div>
    HAML
    engine.render self, :form => f, :transcripts => transcripts
  end

  def display_catalog_name(catalog)
    catalog['cname'] || catalog['catalognodename']
  end

  def display_catalog_link(catalog, children)
    "#{catalog['cname'] || catalog['catalognodename']} #{children.nil? ? '' : " <span class='children-amount'>(#{children.length})</span> <span class='expander'></span>"}"
  end
end
