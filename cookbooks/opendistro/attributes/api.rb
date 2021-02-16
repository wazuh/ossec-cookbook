# frozen_string_literal: true

# Cookbook Name:: opendistro
# Attributes:: api
# Author:: Wazuh <info@wazuh.com>

default['kibana']['wazuh_api_credentials'] = [
  {
    'id' => 'default',
    'url' => 'https://localhost',
    'port' => 55000,
    'username' => 'wazuh-wui',
    'password' => 'wazuh-wui',
    'run_as' => true
  }
]
