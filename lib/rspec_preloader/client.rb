require 'drb/drb'
require_relative 'server'

class RspecPreloader
  class Client

    def self.run(all_arguments)
      new(all_arguments).run
    end

    def run
      DRb.start_service

      rspec_runner.run_rspec(rspec_arguments, STDERR, STDOUT, updated_files)
    end

    private

    def updated_files
      FileSelector.updated_source_files
    end

    def rspec_arguments
      if rspec_preloader_arguments?
        all_arguments[2..-1]
      else
        all_arguments
      end
    end

    def rspec_preloader_arguments?
      all_arguments.first == "--server"
    end

    def server_uri
      if rspec_preloader_arguments?
        "druby://#{all_arguments[1]}:8787"
      else
        SERVER_URI
      end
    end

    def rspec_runner
      @rspec_runner ||= DRbObject.new_with_uri(server_uri)
    end

  end
end
