require 'drb/drb'

class RspecPreloader
  class Client

    SERVER_URI="druby://localhost:8787"

    def self.run(rspec_arguments)
      DRb.start_service

      rspec_runner = DRbObject.new_with_uri(SERVER_URI)
      rspec_runner.run_rspec(rspec_arguments, STDERR, STDOUT)
    end

  end
end
