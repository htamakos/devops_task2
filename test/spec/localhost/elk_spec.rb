require 'spec_helper'
set :docker_container, 'test_docker_container2'

describe package('initscripts') do
  it { should be_installed }
end

describe package('java-1.8.0-openjdk') do
  it { should be_installed }
end

describe command('java -version') do
  its(:stderr) { should match /1.8.0/ }
end

describe yumrepo('elasticsearch') do
  it { should be_enabled }
end

describe package('elasticsearch') do
  it { should be_installed }
end

describe service('elasticsearch') do
  it { should be_enabled }
  it { should be_running }
end

describe package('kibana') do
  it { should be_installed }
end

describe file('/etc/kibana/kibana.yml') do
  it { should exist }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
end

describe service('kibana') do
  it { should be_enabled }
  it { should be_running }
end

describe package('logstash') do
  it { should be_installed }
end

describe file('/etc/init/logstash.conf') do
  it { should_not exist }
end

describe file('/etc/logstash/conf.d/tomcat.conf') do
  it { should exist }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
end

describe file('/opt/logstash') do
  it { should exist }
  it { should be_directory }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
end

describe file('/opt/logstash/patterns') do
  it { should exist }
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
end

describe file('/etc/init.d/logstash') do
  it { should exist }
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 744 }
end

describe service('logstash') do
  it { should be_enabled }
  it { should be_running }
end
