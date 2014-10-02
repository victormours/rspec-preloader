require_relative "rspec_preloader/command_line"

class RspecPreloader

  def self.run(rspec_arguments = nil)
    new(rspec_arguments).run
  end

  def initialize(rspec_arguments)
    @rspec_arguments = rspec_arguments
  end

  def run
    trap_int_signal
    load_spec_helper

    CommandLine.run(@rspec_arguments)
  end

  private

  def trap_int_signal
    trap("INT") do
      puts "Shutting down rspec-preloader"
      exit
    end
  end

  def load_spec_helper
    print "Loading spec_helper..."
    require "#{Dir.pwd}/spec/spec_helper"
    puts "done."
  end

end
