require_relative "spec_helper"
require "minitest/autorun"

describe RspecPreloader do
  it "runs the specs" do
    output = `cd #{File.dirname(__FILE__)}/fixtures; ruby ../../bin/rspec-preloader.rb`
    puts output
  end
end
