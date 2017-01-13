require 'active_fedora/rake_support'

namespace :hydra do
  desc "Start a solr, fedora and rails instance"
  task :server do
    with_server('development') do
      # Specifying HYDRA_BIND_ALL=true will bind to all IPs
      IO.popen("rails server #{'-b 0.0.0.0' if ENV['HYDRA_BIND_ALL']}") do |io|
        begin
          io.each do |line|
            puts line
          end
        rescue Interrupt
          puts "Stopping server"
        end
      end
    end
  end

  desc "Start solr and fedora instances for tests"
  task :test_server do
    with_server('test') do
      begin
        sleep
      rescue Interrupt
        puts "Stopping server"
      end
    end
  end
end
