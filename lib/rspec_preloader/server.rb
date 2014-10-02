require 'drb/drb'

class RspecPreloader
  class Server

    URI="druby://localhost:8787"

    $SAFE = 1   # disable eval() and friends

    def self.run
      DRb.start_service(URI, SpecRunner)
      DRb.thread.join
    end
  end
end
