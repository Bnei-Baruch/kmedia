class MakeLegacySchemaForTest < ActiveRecord::Migration
  def up
    if Rails.env.test?
      sql = <<-SQL
CREATE TABLE IF NOT EXISTS answers (
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  ip varchar(15) NOT NULL DEFAULT '',
  qid varchar(10) NOT NULL DEFAULT '',
  qdata text NOT NULL,
  lang char(3) NOT NULL DEFAULT '',
  PRIMARY KEY (`datetime`,ip,qid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
      SQL
      execute sql
      sql = <<-SQL
CREATE TABLE IF NOT EXISTS banners (
  id int(11) NOT NULL AUTO_INCREMENT,
  langs varchar(50) DEFAULT NULL,
  banner text,
  PRIMARY KEY (id)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=44 ;
      SQL
      execute sql
      sql = <<-SQL
CREATE TABLE IF NOT EXISTS books (
  fileid int(10) NOT NULL AUTO_INCREMENT,
  filename varchar(50) DEFAULT NULL,
  filedate datetime DEFAULT NULL,
  filesize int(10) DEFAULT NULL,
  servername varchar(30) DEFAULT NULL,
  filestatus varchar(10) DEFAULT NULL,
  created datetime DEFAULT NULL,
  updated datetime DEFAULT NULL,
  PRIMARY KEY (fileid),
  KEY servername (servername)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
      SQL
      execute sql
      sql = <<-SQL
CREATE TABLE IF NOT EXISTS booksdesc (
 filedescid int(10) NOT NULL AUTO_INCREMENT,
 fileid int(10) NOT NULL DEFAULT '0',
 filedesc varchar(255) DEFAULT NULL,
 lang char(3) DEFAULT NULL,
 created datetime DEFAULT NULL,
 updated datetime DEFAULT NULL,
 PRIMARY KEY (filedescid),
 KEY fileid (fileid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
      SQL
      execute sql
      sql = <<-SQL
CREATE TABLE IF NOT EXISTS catalognode (
 catalognodeid int(10) NOT NULL AUTO_INCREMENT,
 catalognodename varchar(100) NOT NULL DEFAULT '',
 parentnodeid int(10) DEFAULT NULL,
 created datetime DEFAULT NULL,
 updated datetime DEFAULT NULL,
 catorder int(10) NOT NULL DEFAULT '999',
 secure int(1) NOT NULL DEFAULT '0',
 PRIMARY KEY (catalognodeid),
 UNIQUE KEY cnnamepid (catalognodename,parentnodeid),
 KEY parentnodeid (parentnodeid)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4598 ;
      SQL
      execute sql
      sql = <<-SQL
CREATE TABLE IF NOT EXISTS catnodedesc (
 catnodedescid int(10) NOT NULL AUTO_INCREMENT,
 catalognodeid int(10) NOT NULL DEFAULT '0',
 catalognodename varchar(255) DEFAULT NULL,
 lang char(3) DEFAULT NULL,
 created datetime DEFAULT NULL,
 updated datetime DEFAULT NULL,
 PRIMARY KEY (catnodedescid),
 KEY catalognodeid (catalognodeid),
 KEY cnd_name_idx (catalognodename)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13616 ;
      SQL
      execute sql
      sql = <<-SQL
CREATE TABLE IF NOT EXISTS catnodelessons (
 catalognodeid int(10) NOT NULL DEFAULT '0',
 lessonid int(10) NOT NULL DEFAULT '0',
 PRIMARY KEY (catalognodeid,lessonid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
      SQL
      execute sql
      sql = <<-SQL
CREATE TABLE IF NOT EXISTS filedesc (
 filedescid int(10) NOT NULL AUTO_INCREMENT,
 fileid int(10) NOT NULL DEFAULT '0',
 filedesc varchar(255) DEFAULT NULL,
 lang char(3) DEFAULT NULL,
 created datetime DEFAULT NULL,
 updated datetime DEFAULT NULL,
 PRIMARY KEY (filedescid),
 KEY fileid (fileid),
 KEY fd_name_idx (filedesc)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=490426 ;
      SQL
      execute sql
      sql = <<-SQL
CREATE TABLE IF NOT EXISTS files (
 fileid int(10) NOT NULL AUTO_INCREMENT,
 filename varchar(150) DEFAULT NULL,
 filelang char(3) DEFAULT NULL,
 filetype char(3) DEFAULT NULL,
 filedate datetime DEFAULT NULL,
 filesize int(10) DEFAULT NULL,
 servername varchar(30) DEFAULT 'DEFAULT',
 filestatus varchar(10) DEFAULT NULL,
 created datetime DEFAULT NULL,
 updated datetime DEFAULT NULL,
 lastuser varchar(7) DEFAULT NULL,
 fileclicks int(11) DEFAULT '0',
 PRIMARY KEY (fileid),
 UNIQUE KEY filename (filename),
 KEY servername (servername),
 KEY updated (updated)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=266352 ;
      SQL
      execute sql
      sql = <<-SQL
CREATE TABLE IF NOT EXISTS filetypes (
 typename varchar(20) NOT NULL DEFAULT '',
 extlist varchar(255) DEFAULT NULL,
 pic varchar(20) DEFAULT NULL,
 PRIMARY KEY (typename)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
      SQL
      execute sql
      sql = <<-SQL
 CREATE TABLE IF NOT EXISTS lecturer (
   lecturerid int(11) NOT NULL AUTO_INCREMENT,
   lecturername char(100) NOT NULL DEFAULT '',
   created datetime DEFAULT NULL,
   updated datetime DEFAULT NULL,
   ordnum int(11) NOT NULL DEFAULT '0',
   PRIMARY KEY (lecturerid)
 ) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=202 ;
      SQL
      execute sql
      sql = <<-SQL
CREATE TABLE IF NOT EXISTS lecturerdesc (
 lecturerdescid int(11) NOT NULL AUTO_INCREMENT,
 lecturerid int(11) NOT NULL DEFAULT '0',
 lecturerdesc char(100) NOT NULL DEFAULT '',
 lang char(3) NOT NULL DEFAULT '',
 created datetime DEFAULT NULL,
 updated datetime DEFAULT NULL,
 PRIMARY KEY (lecturerdescid),
 UNIQUE KEY lecturerid (lecturerid,lang)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=18 ;
      SQL
      execute sql
      sql = <<-SQL
CREATE TABLE IF NOT EXISTS lessondesc (
 lessondescid int(10) NOT NULL AUTO_INCREMENT,
 lessonid int(10) NOT NULL DEFAULT '0',
 lessondesc varchar(255) DEFAULT NULL,
 lang char(3) DEFAULT NULL,
 created datetime DEFAULT NULL,
 updated datetime DEFAULT NULL,
 descr text,
 lessondesc_flat varchar(255) DEFAULT NULL,
 descr_flat text,
 PRIMARY KEY (lessondescid),
 KEY lessonid (lessonid),
 KEY ld_name_idx (lessondesc)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=84555 ;
      SQL
      execute sql
      sql = <<-SQL
 CREATE TABLE IF NOT EXISTS lessonfiles (
   lessonid int(10) NOT NULL DEFAULT '0',
   fileid int(10) NOT NULL DEFAULT '0',
   PRIMARY KEY (lessonid,fileid)
 ) ENGINE=MyISAM DEFAULT CHARSET=utf8;
      SQL
      execute sql
      sql = <<-SQL
CREATE TABLE IF NOT EXISTS lessons (
 lessonid int(10) NOT NULL AUTO_INCREMENT,
 lessonname varchar(100) DEFAULT NULL,
 created datetime DEFAULT NULL,
 updated datetime DEFAULT NULL,
 lessondate date DEFAULT NULL,
 lang char(3) DEFAULT NULL,
 lecturerid int(11) DEFAULT NULL,
 secure int(1) NOT NULL DEFAULT '0',
 PRIMARY KEY (lessonid),
 KEY lessonnameidx (lessonname),
 KEY lessondateidx (lessondate),
 KEY lessonlangidx (lang),
 FULLTEXT KEY lessonname (lessonname)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=30480 ;
      SQL
      execute sql
      sql = <<-SQL
CREATE TABLE IF NOT EXISTS lessons_offline (
 lessonid int(11) NOT NULL DEFAULT '0',
 PRIMARY KEY (lessonid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
      SQL
      execute sql
      sql = <<-SQL
CREATE TABLE IF NOT EXISTS music (
 fileid int(10) NOT NULL AUTO_INCREMENT,
 filename varchar(50) DEFAULT NULL,
 filedate datetime DEFAULT NULL,
 filesize int(10) DEFAULT NULL,
 servername varchar(30) DEFAULT NULL,
 filestatus varchar(10) DEFAULT NULL,
 created datetime DEFAULT NULL,
 updated datetime DEFAULT NULL,
 PRIMARY KEY (fileid),
 KEY servername (servername)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
      SQL
      execute sql
      sql = <<-SQL
CREATE TABLE IF NOT EXISTS musicdesc (
 filedescid int(10) NOT NULL AUTO_INCREMENT,
 fileid int(10) NOT NULL DEFAULT '0',
 filedesc varchar(255) DEFAULT NULL,
 lang char(3) DEFAULT NULL,
 created datetime DEFAULT NULL,
 updated datetime DEFAULT NULL,
 PRIMARY KEY (filedescid),
 KEY fileid (fileid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
      SQL
      execute sql
      sql = <<-SQL
CREATE TABLE IF NOT EXISTS search_strings (
 id int(11) NOT NULL AUTO_INCREMENT,
 search_str varchar(255) NOT NULL DEFAULT '',
 search_count int(11) NOT NULL DEFAULT '0',
 PRIMARY KEY (id)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12978 ;
      SQL
      execute sql
      sql = <<-SQL
CREATE TABLE IF NOT EXISTS subscription (
 id int(11) NOT NULL AUTO_INCREMENT,
 email varchar(255) NOT NULL DEFAULT '',
 `name` varchar(50) NOT NULL DEFAULT '',
 rate varchar(10) DEFAULT 'day',
 `last` date DEFAULT NULL,
 created date DEFAULT NULL,
 ipcreated varchar(15) NOT NULL DEFAULT '',
 lang char(3) NOT NULL DEFAULT '',
 valid bool DEFAULT FALSE,
 valcode varchar(10) NOT NULL DEFAULT '',
 lastsuccess bool DEFAULT FALSE,
 PRIMARY KEY (id),
 UNIQUE KEY email (email,`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
      SQL
      execute sql
      sql = <<-SQL
CREATE TABLE IF NOT EXISTS subscription_backup (
 id int(11) NOT NULL DEFAULT '0',
 email varchar(255) NOT NULL DEFAULT '',
 `name` varchar(50) NOT NULL DEFAULT '',
 rate varchar(10) DEFAULT 'day',
 `last` date DEFAULT NULL,
 created date DEFAULT NULL,
 ipcreated varchar(15) NOT NULL DEFAULT '',
 lang char(3) NOT NULL DEFAULT '',
 valid bool DEFAULT FALSE,
 valcode varchar(10) NOT NULL DEFAULT '',
 lastsuccess bool DEFAULT FALSE,
 PRIMARY KEY (id),
 UNIQUE KEY email (email,`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
      SQL
      execute sql
      sql = <<-SQL
CREATE TABLE IF NOT EXISTS tmp_access (
 cnt int(11) DEFAULT NULL,
 filename varchar(150) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
      SQL
      execute sql
      sql = <<-SQL
CREATE TABLE IF NOT EXISTS updated (
 lang char(3) NOT NULL DEFAULT '',
 days int(11) NOT NULL DEFAULT '0',
 ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 `value` mediumblob NOT NULL,
 PRIMARY KEY (lang,days)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
      SQL
      execute sql
      sql = <<-SQL
CREATE TABLE IF NOT EXISTS users (
 id int(11) NOT NULL AUTO_INCREMENT,
 email varchar(255) NOT NULL DEFAULT '',
 encrypted_password varchar(128) NOT NULL DEFAULT '',
 reset_password_token varchar(255) DEFAULT NULL,
 remember_created_at datetime DEFAULT NULL,
 sign_in_count int(11) DEFAULT '0',
 current_sign_in_at datetime DEFAULT NULL,
 last_sign_in_at datetime DEFAULT NULL,
 current_sign_in_ip varchar(255) DEFAULT NULL,
 last_sign_in_ip varchar(255) DEFAULT NULL,
 created_at datetime DEFAULT NULL,
 updated_at datetime DEFAULT NULL,
 first_name varchar(255) DEFAULT '',
 last_name varchar(255) DEFAULT '',
 authentication_token varchar(255) DEFAULT NULL,
 PRIMARY KEY (id),
 UNIQUE KEY index_users_on_email (email),
 UNIQUE KEY index_users_on_reset_password_token (reset_password_token)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=60 ;
      SQL
      execute sql
      sql = <<-SQL
CREATE TABLE IF NOT EXISTS servers (
  servername varchar(30) NOT NULL DEFAULT '',
  httpurl varchar(255) DEFAULT NULL,
  created datetime DEFAULT NULL,
  updated datetime DEFAULT NULL,
  lastuser varchar(16) DEFAULT NULL,
  path varchar(255) DEFAULT NULL,
  PRIMARY KEY (servername)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ;
      SQL
      execute sql
    end
  end

  def down
    execute <<-SQL
DROP TABLE
answers,
banners,
books,
booksdesc,
catalognode,
labels,
label_descriptions,
catnodedesc,
catnodelessons,
content_types,
filedesc,
files,
filetypes,
languages,
lecturer,
lecturerdesc,
lessondesc,
servers;
    SQL

  end
end
