require_relative "spec_helper"
require "minitest/autorun"

class TestRspecPreloader < Minitest::Test
  def preloader_output
    `cd #{File.dirname(__FILE__)}/fixtures; ruby ../../bin/rspec-preloader.rb`.split("\n")
  end

  def test_that_output_has_server_status
    assert_equal preloader_output[0], "Hello"
  end

  def test_spec_helper_gets_loaded
    assert_equal "Loading spec helper", preloader_output[1]
  end

  def test_specs_are_run
    assert_equal  "Running specs", preloader_output[2]
  end
end
