name             'wazuh'
maintainer       'Wazuh Inc.'
maintainer_email 'info@wazuh.com'
license          'Apache 2.0'
description      'Installs and onfigures ossec'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.9'

%w(redhat centos oracle).each do |el|
  supports el, '>= 6.0'
end

supports 'amazon'
supports 'fedora'
supports 'debian', '>= 7.0'
supports 'ubuntu', '>= 12.04'

%w( debian ubuntu ).each do |os|
  supports os
end

depends 'chef-sugar'
depends 'apt'
depends 'poise-python'
depends 'hostsfile'

issues_url 'https://github.com/wazuh/wazuh-chef/issues'
source_url 'https://github.com/wazuh/wazuh-chef'
chef_version '>= 12.14'
