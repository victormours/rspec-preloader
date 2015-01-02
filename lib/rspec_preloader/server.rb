require 'drb/drb'

class RspecPreloader

  SERVER_URI = "druby://localhost:8787"

  class Server

    $SAFE = 1   # disable eval() and friends

    def self.run
      DRb.start_service(SERVER_URI, SpecRunner)
      DRb.thread.join
    end
  end
end
