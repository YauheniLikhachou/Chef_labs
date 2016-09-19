#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


#----------------------------------------------
##      Service Nginx will be installed
#---------------------------------------------
package "nginx" do
  action :install
end

#----------------------------------------------
##           Added virt.conf to nginx
#---------------------------------------------
template "/etc/nginx/conf.d/virt.conf" do
  source "virt.erb"
  variables({
  'nginx_port' => node['nginx']['nginx_port'],
  'jenkins_port' => node['nginx']['jenkins_port'],
  'tomcat_port' => node['nginx']['tomcat_port']
})
end

#----------------------------------------------
##           Service nginx restart
#---------------------------------------------
service 'nginx' do
  action :start
end
