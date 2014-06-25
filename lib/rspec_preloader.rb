require "rspec/core"
require "readline"
require_relative "rspec_preloader/file_watcher"
require_relative "rspec_preloader/rspec_runner"

class RspecPreloader

  def self.run_server(rspec_arguments = [""])
    new(rspec_arguments).run_server
  end

  def initialize(rspec_arguments)
    @rspec_arguments = rspec_arguments
  end

  def run_server
    trap("INT") do
      puts "Shutting down rspec-shell"
      exit
    end
    load_spec_helper

    first_run
    server_loop
  end

  private

  def load_spec_helper
    puts "Loading spec_helper..."
    require "#{Dir.pwd}/spec/spec_helper"
    puts "Done!"
  end

  def first_run
    return if @rspec_arguments == ""
    RspecRunner.run_rspec(@rspec_arguments)
  end

  def server_loop
    while rspec_arguments = Readline.readline("rspec > ", true)
      rspec_arguments_array = process_input(rspec_arguments)
      RspecRunner.run_rspec(rspec_arguments_array)
    end
  end

  def process_input(input)
    input.chomp.split(" ")
  end

end
