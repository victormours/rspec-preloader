require "rspec/core"
require "rspec_preloader/file_watcher"

class RspecPreloader

  def self.run_server(rspec_arguments = [""])
    new(rspec_arguments).run_server
  end

  def initialize(rspec_arguments)
    @rspec_arguments = rspec_arguments
  end

  def run_server
    initial_prompt
    first_run
    # server_loop
  end

  private

  def initial_prompt
    puts "Starting Rspec preloader server"
    puts "Press Ctrl-C to stop"
  end

  def first_run
    return if @rspec_arguments == [""]
    pid = fork do
      require "#{Dir.pwd}/spec/spec_helper"
      FileWatcher.changed_files.each do |file|
        load file
      end
      run_specs(@rspec_arguments)
    end
    Process.wait(pid)
  end

  def server_loop
    trap("INT") do
      puts "Shutting down Rspec server"
      exit
    end

    loop do
      pid = fork do
        require "#{Dir.pwd}/spec/spec_helper"
        puts "Ready to run specs"
        @rspec_arguments = read_rspec_arguments
        FileWatcher.changed_files.each do |file|
          load file
        end
        run_specs(@rspec_arguments)
      end
      Process.wait(pid)
    end
  end

  def run_specs(arguments_array)
    puts "Running $ rspec #{arguments_array.join(" ")}"
    RSpec::Core::Runner.run(arguments_array, STDERR, STDOUT)
  end

  def read_rspec_arguments
    user_input = STDIN.gets.chomp.split(" ")
    user_input == [] ? @rspec_arguments : user_input
  end

end
