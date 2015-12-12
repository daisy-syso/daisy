# unicorn_rails -c /var/www/daisy/current/config/unicorn.rb -E production -D
 
rails_env = ENV['RAILS_ENV'] || 'production'
rails_root  = (rails_env == 'production' ? "/var/www/daisy/current" : `pwd`.chomp)
 
working_directory rails_root
worker_processes  (rails_env == 'production' ? 2 : 2)
preload_app       true
timeout           30

listen      '/tmp/unicorn.sock', :backlog => 2048 if rails_env == 'production'
listen      8080

pid         "#{rails_root}/tmp/pids/unicorn.pid"
stderr_path "#{rails_root}/log/unicorn.log"
stdout_path "#{rails_root}/log/unicorn.log"
 
 
GC.copy_on_write_friendly = true if GC.respond_to?(:copy_on_write_friendly=)
 
before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!
  
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
 
  old_pid = "#{Rails.root}/tmp/pids/unicorn.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end
 
 
after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
 
  worker.user('deploy', 'deploy') if Process.euid == 0 && rails_env == 'production'
end