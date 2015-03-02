require 'json'
require_relative '../../../kitchen/data/spec_helper'

postgresql_packages = %w{ postgresql-client-common }

postgresql_packages.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
  if $node['cleanspeak']['database']['server']['host'] == 'localhost'
    describe service('postgresql') do
      it { should be_enabled }
      it { should be_running }
      describe port(5432) do
        it { should be_listening }
      end
    end
  else
    describe service('postgresql') do
      it { should_not be_enabled }
      it { should_not be_running }
      describe port(5432) do
        it { should_not be_listening }
      end
    end
  end
end
