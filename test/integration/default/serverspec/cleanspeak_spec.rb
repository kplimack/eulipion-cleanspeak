require 'json'
require_relative '../../../kitchen/data/spec_helper'
require 'pp'

file_cache_path = '/tmp/kitchen/cache'

describe "Cleanspeak Server" do
  describe file($node['cleanspeak']['install']['path']) do
    it { should be_directory }
  end

  %w{ cleanspeak-management-interface cleanspeak-webservice cleanspeak-search-engine }.each do |svc|
    describe service(svc) do
      it { should be_running }
      it { should be_enabled }
    end
  end

  license_id = $node['cleanspeak']['config']['licence_id']
  describe file("/usr/local/inversoft/config/#{license_id}.license") do
    it { should be_file }
  end

  describe file("/usr/local/inversoft/config/cleanspeak.properties") do
    it { should be_file }
  end
end
