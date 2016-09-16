#
# Cookbook Name :: web
# Recipe :: default
#

if node.role?('web_nginx')
   include_recipe 'web_nginx'

elsif node.role?('web_apache')
   include_recipe 'web_apache'
end
