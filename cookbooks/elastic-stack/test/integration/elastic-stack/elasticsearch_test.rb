# frozen_string_literal: true

describe packages('elasticsearch') do
  its('statuses') { should cmp 'installed' }
  its('versions') { should cmp "#{input('elk_version')}-1" }
end 

describe file('/etc/elasticsearch/elasticsearch.yml') do
  its('owner') { should cmp 'elasticsearch' }
  its('group') { should cmp 'elasticsearch' }
  its('mode') { should cmp '0660' }
end

describe service('elasticsearch') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe http("https://#{input('node_ip')}:#{input('elastic_port')}/_cluster/health?wait_for_status=green",
              auth: {user: "#{input('elastic_user')}", pass: "#{input('elastic_password')}"},
              ssl_verify: false,
              method: 'GET') do
  its('status') { should cmp 200 }
end 
