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

  def display_show_item(name, value)
    engine = Haml::Engine.new <<-HAML
%p
  %strong #{name.humanize}:
  #{value.to_s.gsub(/\s/, '&nbsp;')}
HAML
    engine.render
  end

  def display_secure(secure_level)
    secure = SECURITY.select{|s| s[:level] == secure_level }.first[:name].downcase
    secure == 'unsecure' ? 'non-secure' : "<span class='label label-#{secure == 'advanced' ? 'important' : 'warning'}'>#{secure.humanize}</span>".html_safe
  end
end
