#!/bin/bash
rpm -ivh /vagrant/installs/chefdk-0.17.17-1.el6.x86_64.rpm
cp -R /vagrant/.chef /root/
cp -R /vagrant/chef_cookbooks /root/
chef-solo -c /root/.chef/solo.rb > /vagrant/chefout.log
