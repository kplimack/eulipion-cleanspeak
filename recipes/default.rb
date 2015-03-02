#
# Cookbook Name:: eulipion-cleanspeak
# Recipe:: default
#
# Copyright (C) 2015 Jake Plimack
#
# All rights reserved - Do Not Redistribute
#


include_recipe node[:cleanspeak][:database][:server][:type]
if node[:cleanspeak][:database][:server][:host] == 'localhost'
  include_recipe "#{node[:cleanspeak][:database][:server][:type]}::server"
end
