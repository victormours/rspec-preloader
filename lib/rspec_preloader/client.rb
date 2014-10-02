require 'drb/drb'
require_relative 'server'

class RspecPreloader
  class Client

    def self.run(rspec_arguments)
      DRb.start_service

      rspec_runner = DRbObject.new_with_uri(SERVER_URI)
      rspec_runner.run_rspec(rspec_arguments, STDERR, STDOUT)
    end

  end
end
