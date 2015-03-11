#
# Cookbook Name:: eulipion-cleanspeak
# Recipe:: default
#
# Copyright (C) 2015 Jake Plimack
#
# All rights reserved - Do Not Redistribute
#

require 'json'
require 'pp'

node[:cleanspeak][:install][:cookbooks].each { |cb| include_recipe cb }

dbserver_recipe = node[:cleanspeak][:database][node[:cleanspeak][:database][:server][:type]][:cookbook]

include_recipe dbserver_recipe
if node[:cleanspeak][:database][:server][:host] == 'localhost'
  include_recipe "#{dbserver_recipe}::server"
end

directory node[:cleanspeak][:install][:path] do
  recursive true
end

case node[:cleanspeak][:database][:server][:auth]
when 'citadel'
  conf = JSON.parse(citadel('show-chef')[node[:cleanspeak][:database][:server][:citadel_path]])
  username = conf['username']
  password = conf['password']
  auth_token = conf['auth_token']
  license = citadel('show-chef')["apps/#{node[:cleanspeak][:config][:license_id]}.license"]
end

node[:cleanspeak][:source][node[:platform_family]].each do |key,src|
  filename = src[:url].split('/').last
  remote_file "#{Chef::Config[:file_cache_path]}/#{filename}" do
    source src[:url]
    #checksum src[:checksum]
    notifies :run, "execute[#{src[:notifies]}]", :immediately unless src[:notifies].nil?
  end

  if filename.include? '.deb'
    dpkg_package filename do
      source "#{Chef::Config[:file_cache_path]}/#{filename}"
      action :install
    end


    unless src[:service].nil?
      service src[:service] do
        supports [:start, :stop, :restart]
        action [:enable, :start]
      end
    end
  end
end

db_conf = (node[:cleanspeak][:database][:server]).to_hash
db_conf[:username] = username
db_conf[:password] = password
db_conf[:port] = node[:cleanspeak][:database][node[:cleanspeak][:database][:server][:type]][:port]
db_conf = Hash[db_conf.map { |(k,v)| [ k.to_sym, v ] }]

config = (node[:cleanspeak][:config]).to_hash
config[:auth_token] = auth_token
config = Hash[config.map { |(k,v)| [ k.to_sym, v ] }]

template "#{node[:cleanspeak][:config][:path]}/config/cleanspeak.properties" do
  source 'cleanspeak.properties.erb'
  variables({
              config: config,
              tomcat_config: node[:cleanspeak][:config][:tomcat],
              db_config: db_conf,
              email_config: node[:cleanspeak][:email]
            })
  notifies :restart, "service[cleanspeak-management-interface]"
  notifies :restart, "service[cleanspeak-webservice]"
  notifies :restart, "service[cleanspeak-search-engine]"
end

include_recipe 'eulipion-cleanspeak::database'

file "#{node[:cleanspeak][:config][:path]}/config/#{node[:cleanspeak][:config][:license_id]}.license" do
  content license
end

