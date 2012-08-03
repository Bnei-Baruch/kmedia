module Admin::SuidHelper

  def display_suid_field (f)
    engine = Haml::Engine.new <<-HAML
.row
  %h3 System name
  .span4
    = form.input :suid, label: 'System name', hint: 'Short unique identifier, length 3..20, no spaces.'
  .span8
    %h4 Existing names
    %div{id: "existing_suids"}
    HAML

    engine.render self, form: f
  end

end
