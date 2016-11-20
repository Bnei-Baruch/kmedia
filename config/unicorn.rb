# unicorn_rails -c config/unicorn.rb -E production -D
rails_env = ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'production'
rails_root = ENV['RAILS_ROOT'] || '/sites/kmedia/prod'

# 16 workers and 1 master
worker_processes(rails_env == 'production' ? 4 : 4)

working_directory = rails_root
pid rails_root + '/tmp/pids/unicorn.pid'

# Load rails+github.git into the master before forking workers
# for super-fast worker spawn times
preload_app true

# Restart any workers that haven't responded in 30 seconds
timeout 30

# Listen on a Unix data socket
listen 3001 # "#{Rails.root}/tmp/sockets/unicorn.sock", :backlog => 2048

##
# REE

# http://www.rubyenterpriseedition.com/faq.html#adapt_apps_for_cow
GC.respond_to?(:copy_on_write_friendly=) && GC.copy_on_write_friendly = true

before_fork do |server, worker|
  ##
  # When sent a USR2, Unicorn will suffix its pidfile with .oldbin and
  # immediately start loading up a new version of itself (loaded with a new
  # version of our app). When this new Unicorn is completely loaded
  # it will begin spawning workers. The first worker spawned will check to
  # see if an .oldbin pidfile exists. If so, this means we've just booted up
  # a new Unicorn and need to tell the old one that it can now die. To do so
  # we send it a QUIT.
  #
  # Using this method we get 0 downtime deploys.

  old_pid = Rails.root + '/tmp/pids/unicorn.pid.oldbin'
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill('QUIT', File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|

  ##
  # Unicorn master loads the app then forks off workers - because of the way
  # Unix forking works, we need to make sure we aren't using any of the parent's
  # sockets, e.g. db connection

  ActiveRecord::Base.establish_connection
  # CHIMNEY.client.connect_to_server
  # Redis and Memcached would go here but their connections are established
  # on demand, so the master never opens a socket

  ##
  # Unicorn master is started as root, which is fine, but let's
  # drop the workers to git:git

  begin
    uid, gid = Process.euid, Process.egid
    user, group = %w(kmedia kmedia)
    worker.user(user, group)
    target_uid = Etc.getpwnam(user).uid
    target_gid = Etc.getgrnam(group).gid
    if uid != target_uid || gid != target_gid
      Process.initgroups(user, target_gid)
      Process::GID.change_privilege(target_gid)
      Process::UID.change_privilege(target_uid)
    end
  rescue => e
    if rails_env == 'development'
      STDERR.puts "couldn't change user, oh well"
    else
      raise e
    end
  end
end

