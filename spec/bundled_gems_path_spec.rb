require File.dirname(__FILE__) + '/spec_helper'

describe "where bundled gems get installed" do
  it "is different for each app" do
    deploy1 = EY::Deploy.new(EY::Deploy::Configuration.new('app' => 'alice'))
    deploy2 = EY::Deploy.new(EY::Deploy::Configuration.new('app' => 'bob'))

    deploy1.bundled_gems_path.should_not == deploy2.bundled_gems_path
  end
end
