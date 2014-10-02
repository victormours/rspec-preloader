require "rspec/core"
require "readline"
require_relative "rspec_preloader/spec_runner"

class RspecPreloader

  def self.run_server(rspec_arguments = [""])
    new(rspec_arguments).run_server
  end

  def initialize(rspec_arguments)
    @rspec_arguments = rspec_arguments
  end

  def run_server
    trap("INT") do
      puts "Shutting down rspec-preloader"
      exit
    end
    load_spec_helper

    first_run
    server_loop
  end

  private

  def load_spec_helper
    print "Loading spec_helper..."
    require "#{Dir.pwd}/spec/spec_helper"
    puts "done."
  end

  def first_run
    return if @rspec_arguments == ""
    Readline::HISTORY << @rspec_arguments.join(" ")
    SpecRunner.run_rspec(@rspec_arguments)
  end

  def server_loop
    loop do
      rspec_arguments = Readline.readline("rspec > ", true)
      break if [nil, "exit"].include?(rspec_arguments)
      rspec_arguments_array = rspec_arguments.chomp.split(" ")
      SpecRunner.run_rspec(rspec_arguments_array)
    end
  end

end
