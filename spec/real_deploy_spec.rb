require File.dirname(__FILE__) + '/spec_helper'

describe "Deploying" do
  include FullDeployHelpers

  shared_examples_for "all deploys" do
    it "creates a REVISION file" do
      File.exist?(File.join(@deploy_dir, 'current', 'REVISION')).should be_true
    end

    it "runs 'bundle install' with --deployment" do
      bundle_install_cmd = @deployer.commands.grep(/bundle _\S+_ install/).first
      bundle_install_cmd.should_not be_nil
      bundle_install_cmd.should include('--deployment')
    end

    it "creates binstubs somewhere out of the way" do
      File.exist?(File.join(@deploy_dir, 'current', 'ey_bundler_binstubs', 'rake')).should be_true
    end

    it "has the binstubs in the path when migrating" do
      File.read(File.join(@deploy_dir, 'path-when-migrating')).should include('ey_bundler_binstubs')
    end
  end

  describe "on appcloud" do
    before(:all) {
      @deploy_config = { "stack" => "nginx_passenger" }
      @deployer = run_test_deploy
    }

    it "restarts the app servers" do
      File.exist?(File.join(@deploy_dir, 'current', 'restart')).should be_true
    end

    it_should_behave_like "all deploys"
  end
end
