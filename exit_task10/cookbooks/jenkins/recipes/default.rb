#
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#-------------------------------------------------
##---------------added jenkins repository--------
#-------------------------------------------------
execute 'adding jenkins repo' do
  command "wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo && rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key"
  not_if { File.exist? "/etc/yum.repos.d/jenkins.repo" } 
end

#-------------------------------------------------
####        Added for installing aditional package 
##--------------------------------------------------
package ["git", "unzip", "jenkins"]

#-------------------------------------------------
###-        customized jenkins port 
#-------------------------------------------------- 
template '/etc/sysconfig/jenkins' do
  source "jenkins.erb"
  mode 0755
  owner 'root'
  group 'root'
  variables({
    'jenkins_port' => node['jenkins_port']
  })
end

#-------------------------------------------------
##         added plugins for jenkins
#-------------------------------------------------
remote_directory "/var/lib/jenkins" do
source 'jenkins'
owner 'jenkins'
group 'jenkins'
mode 0755
action :create
end


#-------------------------------------------------
##         added jenkins-user for tomcat
#-------------------------------------------------
group 'tomcat' do
  action :modify
  members 'jenkins'
  append true
end

#-------------------------------------------------
##         Change owner for jenkins files
#-------------------------------------------------
execute 'jenkins home chown' do
  command "chown -R jenkins:jenkins /var/lib/jenkins"
end


#-------------------------------------------------
###         Restart service jenkins
##-------------------------------------------------
service 'jenkins' do
  action [ :enable, :start ]
end

