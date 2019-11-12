if platform_family?('rhel', 'redhat', 'centos', 'amazon')
    yum_package 'epl-release' do
        action :install
end


if platform_family?('debian', 'ubuntu')
    apt_package 'nginx' do
        action :install
    end
elsif platform_family?('rhel', 'redhat', 'centos', 'amazon')
    yum_package 'nginx' do
        action :install
    end
else
    raise "Platform Family is not in {'debian', 'ubuntu', 'rhel', 'redhat', 'centos', 'amazon'} - Not Supported"
end


directory '/etc/ssl/certs' do
    mode '0755'
    recursive true
    action :create
end

directory '/etc/ssl/private' do
    mode '0755'
    recursive true
    action :create
end

bash 'Generate a self-signed ceritificate and a key' do
    code <<-EOH
    openssl req -x509 -batch -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/kibana-access.key -out /etc/ssl/certs/kibana-access.pem
    EOH
end

template '/etc/nginx/sites-available/default' do
    source 'nginx.erb'
    owner 'root'
    group 'root'
    mode '0644'
end

if platform_family?('debian', 'ubuntu')
    apt_package 'apache2-utils' do
        action :install
    end
elsif platform_family?('rhel', 'redhat', 'centos', 'amazon')
    yum_package 'httpd' do
        action :install
    end
else
    raise "Platform Family is not in {'debian', 'ubuntu', 'rhel', 'redhat', 'centos', 'amazon'} - Not Supported"
end

if platform_family?('rhel', 'redhat', 'centos', 'amazon')
    service "httpd" do
        supports :start => true, :stop => true, :restart => true, :reload => true
        action [:restart]
    end
end


node.override['htpasswd']['install_method'] = 'ruby'
include_recipe 'htpasswd::default'

htpasswd "/etc/nginx/conf.d/kibana.htpasswd" do
    user "user-1"
    password "kibana01"
end

service "nginx" do
    supports :start => true, :stop => true, :restart => true, :reload => true
    action [:restart]
end