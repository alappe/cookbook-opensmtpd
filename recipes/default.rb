#
# Cookbook Name:: opensmtpd
# Recipe:: default
#
# Copyright 2013, kaeufli.ch
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

template "/etc/init/opensmtpd.conf" do
  source "upstart.erb"
  mode 0600
end

service 'opensmtpd' do
  provider Chef::Provider::Service::Upstart
  supports :start => true, :restart => true, :stop => true, :status => true
  action :nothing
end

directory node['opensmtpd']['privsep']['empty_dir'] do
  action :create
  user "nobody"
  group "nogroup"
end

# Needed users:
%w{_smtpd _smtpq _smtpf}.each do |user|
  user user do
    system true
    comment "OpenSMTPD privilege separation user"
    shell node['opensmtpd']['privsep']['user_shell']
    home node['opensmtpd']['privsep']['empty_dir']
  end
end

# Dependencies:
%w{libtool autoconf automake bison openssl libdb-dev libevent-dev}.each do |pkg|
  package pkg do
    action :install
  end
end

git node['opensmtpd']['src_dir'] do
  repository node['opensmtpd']['git_url']
  revision node['opensmtpd']['git_rev']
  action :checkout
end

execute "bootstrap OpenSMTPD" do
  cwd node['opensmtpd']['src_dir']
  command "./bootstrap"
  not_if { ::File.exists?("#{node['opensmtpd']['src_dir']}/configure") }
end

execute "build OpenSMTPD" do
  cwd node['opensmtpd']['src_dir']
  command "./configure --prefix=#{node['opensmtpd']['prefix']} --sysconfdir=#{node['opensmtpd']['config_dir']} --with-mantype=doc && make && make install"
  not_if { ::File.exists?("#{node['opensmtpd']['prefix']}/sbin/smtpd") }
end

# Create the configured files, if db also run makemap on them…
node['opensmtpd']['smtpd.conf']['tables'].each do |name,table|
  template table['path'] do
    source "table.erb"
    mode 0640
    user "_smtpd"
    group "_smtpd"
    variables(
      'content' => table['content']
    )
  end

  execute "makemap #{table['path']}" do
    command "#{node['opensmtpd']['prefix']}/sbin/makemap #{table['path']}"
    only_if { table['type'] == 'db' }
  end
end

template "#{node['opensmtpd']['config_dir']}/smtpd.conf" do
  source "smtpd.conf.erb"
  user "_smtpd"
  group "_smtpd"
  mode 0644
  notifies :reload, 'service[opensmtpd]', :delayed
end

service 'opensmtpd' do
  action [:enable, :start]
end
