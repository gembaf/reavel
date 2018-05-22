worker_processes 3

shared_path = '/srv/www/reavel/shared'
current_path = '/srv/www/reavel/current'

listen File.expand_path('tmp/sockets/unicorn.sock', shared_path)
pid File.expand_path('tmp/pids/unicorn.pid', shared_path)

stderr_path File.expand_path('log/unicorn.log', current_path)
stdout_path File.expand_path('log/unicorn.log', current_path)

working_directory current_path

preload_app true

before_fork do |_server, _worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |_server, _worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.establish_connection
end

