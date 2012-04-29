# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
puts '--> Languages'
[{:code3 => "ENG", :language =>"English", :locale => 'en'},
{:code3 => "HEB", :language =>"Hebrew", :locale => 'he'},
{:code3 => "RUS", :language =>"Russian", :locale => 'ru'},
{:code3 => "SPA", :language =>"Spanish", :locale => 'es'},
{:code3 => "ITA", :language =>"Italian", :locale => 'it'},
{:code3 => "GER", :language =>"German", :locale => 'de'},
{:code3 => "DUT", :language =>"Dutch", :locale => 'nl'},
{:code3 => "FRE", :language =>"French", :locale => 'fr'},
{:code3 => "POR", :language =>"Portuguese", :locale => 'pt'},
{:code3 => "TRK", :language =>"Turkish", :locale => 'tk'},
{:code3 => "POL", :language =>"Polish", :locale => 'pl'},
{:code3 => "ARB", :language =>"Arabic", :locale => 'ar'},
{:code3 => "HUN", :language =>"Hungarian", :locale => 'hu'},
{:code3 => "FIN", :language =>"Finnish", :locale => 'fi'},
{:code3 => "LIT", :language =>"Lithuanian", :locale => 'lt'},
{:code3 => "JPN", :language =>"Japanese", :locale => 'ja'},
{:code3 => "BUL", :language =>"Bulgarian", :locale => 'bg'},
{:code3 => "GEO", :language =>"Georgian", :locale => 'ka'},
{:code3 => "NOR", :language =>"Norwegian", :locale => 'no'},
{:code3 => "SWE", :language =>"Swedish", :locale => 'sw'},
{:code3 => "HRV", :language =>"Croatian", :locale => 'hr'},
{:code3 => "CHN", :language =>"Chinese", :locale => 'zh'},
{:code3 => "FAR", :language =>"Persian", :locale => 'fa'},
{:code3 => "ROU", :language =>"Romanian", :locale => 'ro'},
].each{|e| Language.find_or_create_by_locale(e)}

puts '--> Roles'
[
  {:name => 'SuperAdmin', :description => 'יכול הכל'},
  {:name => 'ArchiveAdmin', :description => 'הכל חוץ ממחיקת קבצים וניהול הרשאות'},
  {:name => 'Operator', :description => 'עדכון פרטים מרשימות קיימות (לא יכול להוסיף קטלוג, שפה או מרצה חדשים) ותיאורים. אסור לטפל בהרשאות של קבצים.'},
  {:name => 'ContentManager', :description => 'יכול לעדכן רק תיאורים, כולל תוכניות ישנות'},
  {:name => 'APIUser', :description => 'API user'},
].each{|r| Role.find_or_create_by_name(r)}

puts '--> Users'
[
  {:user => {:email => 'vshiray@gmail.com', :password => 'kmedia'}, :role => 'SuperAdmin'},
  {:user => {:email => 'mgorodetsky@gmail.com', :password => 'kmedia'}, :role => 'SuperAdmin'},
  {:user => {:email => 'gshilin@gmail.com', :password => 'kmedia'}, :role => 'SuperAdmin'},
  {:user => {:email => 'ramigg@gmail.com', :password => 'kmedia'}, :role => 'SuperAdmin'},
  {:user => {:email => 'archiveadmin@kbb1.com', :password => 'kmedia'}, :role => 'ArchiveAdmin'},
  {:user => {:email => 'operator@kbb1.com', :password => 'kmedia'}, :role => 'Operator'},
  {:user => {:email => 'contentmanager@kbb1.com', :password => 'kmedia'}, :role => 'ContentManager'},
].each{|e|
  user = User.find_or_create_by_email(e[:user])
  user.roles << Role.find_by_name(e[:role])
}

puts '--> Container Types'
[
    {:name => 'Program', :pattern => 'program'},
    {:name => 'Short clip', :pattern => 'clip'},
    {:name => 'Song', :pattern => 'song'},
    {:name => 'Lesson', :pattern => 'lesson'},
    {:name => 'Lecture', :pattern => 'lecture'},
    {:name => 'Book', :pattern => 'book'},
    {:name => 'Declamation', :pattern => 'declamation'},
    {:name => 'Audio Disk', :pattern => 'audiodisk'},
    {:name => 'Video Disk', :pattern => 'videodisk'},
    {:name => 'Text', :pattern => 'text'},
    {:name => 'Transcript', :pattern => 'tamlil', :secure => 4},
    {:name => 'Magazine', :pattern => 'magazine'},
].each{|r| ContentType.find_or_create_by_pattern(r)}


puts '--> Departments'
[
    {:name => 'צוות שיעור בוקר'},
    {:name => 'קבלה מדיה רוסית'},
    {:name => 'קבלה מדיה עברית'},
    {:name => 'מילות מפתח עברית'},
    {:name => 'מילות מפתח רוסית'},
    {:name => 'תיאורים נוספים'},
].each { |r| Department.find_or_create_by_name(r) }


puts '--> Done'