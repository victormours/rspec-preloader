require_relative "rspec_preloader/command_line"
require_relative "rspec_preloader/server"
require_relative "rspec_preloader/client"

class RspecPreloader

  def self.run(rspec_arguments = nil)
    setup
    CommandLine.run(rspec_arguments)
  end

  def self.run_server
    setup
    Server.run
  end

  def self.run_client(rspec_arguments)
    Client.run(rspec_arguments)
  end

  private

  def self.setup
    trap_int_signal
    load_spec_helper
  end

  def self.trap_int_signal
    trap("INT") do
      puts "Shutting down rspec-preloader"
      exit
    end
  end

  def self.load_spec_helper
    print "Loading spec_helper..."
    load "#{Dir.pwd}/spec/spec_helper.rb"
    puts "done."
  end

end
