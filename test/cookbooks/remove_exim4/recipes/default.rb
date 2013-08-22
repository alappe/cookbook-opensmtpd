#
# Cookbook Name:: remove_exim4
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if platform? 'debian'
  service 'exim4' do
    provider Chef::Provider::Service::Init::Debian
    action :stop
  end

  package 'exim4' do
    action :remove
  end
end
