require 'json'
require_relative '../../../kitchen/data/spec_helper'
require 'pp'


describe "Java" do
  describe command('java -version') do
    its(:stdout) { should match /java version \"1.7/ }
    its(:exit_status) { should eq 0 }
  end
end
