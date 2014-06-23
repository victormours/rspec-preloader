require "rspec/core"
require_relative "rspec_preloader/file_watcher"

class RspecPreloader

  def self.run_server(rspec_arguments = [""])
    new(rspec_arguments).run_server
  end

  def initialize(rspec_arguments)
    @rspec_arguments = rspec_arguments
  end

  def run_server
    initial_prompt
    require "#{Dir.pwd}/spec/spec_helper"
    first_run

    trap("INT") do
      puts "Shutting down Rspec server"
      exit
    end

    server_loop
  end

  private

  def initial_prompt
    puts "Starting Rspec preloader server"
    puts "Press Ctrl-C to stop"
  end

  def first_run
    return if @rspec_arguments == ""
    RspecRunner.run_rspec(@rspec_arguments)
  end

  def server_loop
    loop do
      rspec_arguments = read_rspec_arguments
      puts "Running $ rspec #{rspec_arguments.join(" ")}"
      RspecRunner.run_rspec(rspec_arguments)
    end
  end

  def read_rspec_arguments
    user_input = STDIN.gets.chomp.split(" ")
    user_input == [] ? @rspec_arguments : user_input
  end

end
