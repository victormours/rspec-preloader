require_relative "rspec_preloader/command_line"
require_relative "rspec_preloader/server"

class RspecPreloader

  def self.run(rspec_arguments = nil)
    setup
    CommandLine.run(rspec_arguments)
  end

  def self.run_server
    setup
    Server.run
  end

  def self.setup
    trap_int_signal
    load_spec_helper
  end

  private

  def self.trap_int_signal
    trap("INT") do
      puts "Shutting down rspec-preloader"
      exit
    end
  end

  def self.load_spec_helper
    print "Loading spec_helper..."
    require "#{Dir.pwd}/spec/spec_helper"
    puts "done."
  end

end
