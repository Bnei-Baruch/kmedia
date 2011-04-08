# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110403102831) do

  create_table "answers", :id => false, :force => true do |t|
    t.timestamp "datetime",                               :null => false
    t.string    "ip",       :limit => 15, :default => "", :null => false
    t.string    "qid",      :limit => 10, :default => "", :null => false
    t.text      "qdata",                                  :null => false
    t.string    "lang",     :limit => 3,  :default => "", :null => false
  end

  create_table "banners", :force => true do |t|
    t.string "langs",  :limit => 50
    t.text   "banner"
  end

  create_table "books", :primary_key => "fileid", :force => true do |t|
    t.string   "filename",   :limit => 50
    t.datetime "filedate"
    t.integer  "filesize"
    t.string   "servername", :limit => 30
    t.string   "filestatus", :limit => 10
    t.datetime "created"
    t.datetime "updated"
  end

  add_index "books", ["servername"], :name => "servername"

  create_table "booksdesc", :primary_key => "filedescid", :force => true do |t|
    t.integer  "fileid",                :default => 0, :null => false
    t.string   "filedesc"
    t.string   "lang",     :limit => 3
    t.datetime "created"
    t.datetime "updated"
  end

  add_index "booksdesc", ["fileid"], :name => "fileid"

  create_table "catalognode", :primary_key => "catalognodeid", :force => true do |t|
    t.string   "catalognodename", :limit => 100, :default => "",  :null => false
    t.integer  "parentnodeid"
    t.datetime "created"
    t.datetime "updated"
    t.integer  "catorder",                       :default => 999, :null => false
    t.integer  "secure",                         :default => 0,   :null => false
  end

  add_index "catalognode", ["catalognodename", "parentnodeid"], :name => "cnnamepid", :unique => true
  add_index "catalognode", ["parentnodeid"], :name => "parentnodeid"

  create_table "catnodedesc", :primary_key => "catnodedescid", :force => true do |t|
    t.integer  "catalognodeid",                :default => 0, :null => false
    t.string   "catalognodename"
    t.string   "lang",            :limit => 3
    t.datetime "created"
    t.datetime "updated"
  end

  add_index "catnodedesc", ["catalognodeid"], :name => "catalognodeid"
  add_index "catnodedesc", ["catalognodename"], :name => "cnd_name_idx"

  create_table "catnodelessons", :id => false, :force => true do |t|
    t.integer "catalognodeid", :default => 0, :null => false
    t.integer "lessonid",      :default => 0, :null => false
  end

  create_table "filedesc", :primary_key => "filedescid", :force => true do |t|
    t.integer  "fileid",                :default => 0, :null => false
    t.string   "filedesc"
    t.string   "lang",     :limit => 3
    t.datetime "created"
    t.datetime "updated"
  end

  add_index "filedesc", ["filedesc"], :name => "fd_name_idx"
  add_index "filedesc", ["fileid"], :name => "fileid"

  create_table "files", :primary_key => "fileid", :force => true do |t|
    t.string   "filename",   :limit => 150
    t.string   "filelang",   :limit => 3
    t.string   "filetype",   :limit => 3
    t.datetime "filedate"
    t.integer  "filesize"
    t.string   "servername", :limit => 30,  :default => "DEFAULT"
    t.string   "filestatus", :limit => 10
    t.datetime "created"
    t.datetime "updated"
    t.string   "lastuser",   :limit => 7
    t.integer  "fileclicks",                :default => 0
  end

  add_index "files", ["filename"], :name => "filename", :unique => true
  add_index "files", ["servername"], :name => "servername"
  add_index "files", ["updated"], :name => "updated"

  create_table "filetypes", :primary_key => "typename", :force => true do |t|
    t.string "extlist"
    t.string "pic",     :limit => 20
  end

  create_table "languages", :force => true do |t|
    t.string "locale"
    t.string "code3"
    t.string "language"
  end

  create_table "lecturer", :primary_key => "lecturerid", :force => true do |t|
    t.string   "lecturername", :limit => 100, :default => "", :null => false
    t.datetime "created"
    t.datetime "updated"
    t.integer  "ordnum",                      :default => 0,  :null => false
  end

  create_table "lecturerdesc", :primary_key => "lecturerdescid", :force => true do |t|
    t.integer  "lecturerid",                  :default => 0,  :null => false
    t.string   "lecturerdesc", :limit => 100, :default => "", :null => false
    t.string   "lang",         :limit => 3,   :default => "", :null => false
    t.datetime "created"
    t.datetime "updated"
  end

  add_index "lecturerdesc", ["lecturerid", "lang"], :name => "lecturerid", :unique => true

  create_table "lessondesc", :primary_key => "lessondescid", :force => true do |t|
    t.integer  "lessonid",                     :default => 0, :null => false
    t.string   "lessondesc"
    t.string   "lang",            :limit => 3
    t.datetime "created"
    t.datetime "updated"
    t.text     "descr"
    t.string   "lessondesc_flat"
    t.text     "descr_flat"
  end

  add_index "lessondesc", ["lessondesc", "descr"], :name => "lessondesc"
  add_index "lessondesc", ["lessondesc"], :name => "ld_name_idx"
  add_index "lessondesc", ["lessonid"], :name => "lessonid"

  create_table "lessonfiles", :id => false, :force => true do |t|
    t.integer "lessonid", :default => 0, :null => false
    t.integer "fileid",   :default => 0, :null => false
  end

  create_table "lessons", :primary_key => "lessonid", :force => true do |t|
    t.string   "lessonname", :limit => 100
    t.datetime "created"
    t.datetime "updated"
    t.date     "lessondate"
    t.string   "lang",       :limit => 3
    t.integer  "lecturerid"
    t.integer  "secure",                    :default => 0, :null => false
  end

  add_index "lessons", ["lang"], :name => "lessonlangidx"
  add_index "lessons", ["lessondate"], :name => "lessondateidx"
  add_index "lessons", ["lessonname"], :name => "lessonname"
  add_index "lessons", ["lessonname"], :name => "lessonnameidx"

  create_table "lessons_offline", :primary_key => "lessonid", :force => true do |t|
  end

  create_table "music", :primary_key => "fileid", :force => true do |t|
    t.string   "filename",   :limit => 50
    t.datetime "filedate"
    t.integer  "filesize"
    t.string   "servername", :limit => 30
    t.string   "filestatus", :limit => 10
    t.datetime "created"
    t.datetime "updated"
  end

  add_index "music", ["servername"], :name => "servername"

  create_table "musicdesc", :primary_key => "filedescid", :force => true do |t|
    t.integer  "fileid",                :default => 0, :null => false
    t.string   "filedesc"
    t.string   "lang",     :limit => 3
    t.datetime "created"
    t.datetime "updated"
  end

  add_index "musicdesc", ["fileid"], :name => "fileid"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "search_strings", :force => true do |t|
    t.string  "search_str",   :default => "", :null => false
    t.integer "search_count", :default => 0,  :null => false
  end

  create_table "servers", :primary_key => "servername", :force => true do |t|
    t.string   "httpurl"
    t.datetime "created"
    t.datetime "updated"
    t.string   "lastuser", :limit => 16
    t.string   "path"
  end

  create_table "subscription", :force => true do |t|
    t.string "email",                     :default => "",    :null => false
    t.string "name",        :limit => 50, :default => "",    :null => false
    t.string "rate",        :limit => 10, :default => "day"
    t.date   "last"
    t.date   "created"
    t.string "ipcreated",   :limit => 15, :default => "",    :null => false
    t.string "lang",        :limit => 3,  :default => "",    :null => false
    t.string "valid",       :limit => 0,  :default => "N"
    t.string "valcode",     :limit => 10, :default => "",    :null => false
    t.string "lastsuccess", :limit => 0,  :default => "N"
  end

  add_index "subscription", ["email", "name"], :name => "email", :unique => true

  create_table "subscription_backup", :force => true do |t|
    t.string "email",                     :default => "",    :null => false
    t.string "name",        :limit => 50, :default => "",    :null => false
    t.string "rate",        :limit => 10, :default => "day"
    t.date   "last"
    t.date   "created"
    t.string "ipcreated",   :limit => 15, :default => "",    :null => false
    t.string "lang",        :limit => 3,  :default => "",    :null => false
    t.string "valid",       :limit => 0,  :default => "N"
    t.string "valcode",     :limit => 10, :default => "",    :null => false
    t.string "lastsuccess", :limit => 0,  :default => "N"
  end

  add_index "subscription_backup", ["email", "name"], :name => "email", :unique => true

  create_table "tmp_access", :id => false, :force => true do |t|
    t.integer "cnt"
    t.string  "filename", :limit => 150
  end

  create_table "updated", :id => false, :force => true do |t|
    t.string    "lang",  :limit => 3,        :default => "", :null => false
    t.integer   "days",                      :default => 0,  :null => false
    t.timestamp "ts",                                        :null => false
    t.binary    "value", :limit => 16777215,                 :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
