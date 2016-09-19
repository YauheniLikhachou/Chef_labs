#
# Cookbook Name:: tomcat
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#



#----------------------------------------------
##      Service Tomcat will be installed
#---------------------------------------------
package ["tomcat","tomcat-webapps"]

#----------------------------------------------
###           Added custom port 
#---------------------------------------------
template '/etc/tomcat/server.xml' do
  source "server.erb"
  mode 0755
  owner 'tomcat'
  group 'tomcat'
  variables({
    'tomcat_port' => node['tomcat_port']
  })
end

#----------------------------------------------
##      Service Tomcat will be restarted
#---------------------------------------------
service 'tomcat' do
  action [ :enable, :restart ]
end



