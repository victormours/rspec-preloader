require "rspec/core"
require "rspec_preloader/file_watcher"

class RspecPreloader

  def self.run_server(rspec_arguments = "")
    new(rspec_arguments).run_server
  end

  def initialize(rspec_arguments)
    @rspec_arguments = rspec_arguments
  end

  def run_server
    initial_prompt
    first_run
    server_loop
  end

  private

  def initial_prompt
    puts "Starting Rspec preloader server"
  end

  def first_run
    return if @rspec_arguments == ""
    pid = fork do
      require "#{Dir.pwd}/spec/spec_helper"
      FileWatcher.changed_files.each do |file|
        load file
      end
      RSpec::Core::Runner.run([@rspec_arguments], STDERR, STDOUT)
    end
    Process.wait(pid)
  end

  def server_loop
    loop do
      pid = fork do
        require "#{Dir.pwd}/spec/spec_helper"
        puts "Ready to run specs"
        @rspec_arguments = STDIN.gets.chomp
        FileWatcher.changed_files.each do |file|
          load file
        end
        RSpec::Core::Runner.run([@rspec_arguments], STDERR, STDOUT)
      end
      Process.wait(pid)
    end
  end

end
