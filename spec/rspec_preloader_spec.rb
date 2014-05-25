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

  def test_changed_source_file_is_loaded
    source_filename = File.expand_path("fake_project/app/some_class.rb", __dir__)

    File.open(source_filename, 'w') do |file|
      file.puts "Loading source file"

    end

    assert_equal "Loading source file", preloader_output[2]

    File.delete(source_filename)
  end

  def test_specs_are_run
    assert_equal  "Running specs", preloader_output[3]
  end
end
