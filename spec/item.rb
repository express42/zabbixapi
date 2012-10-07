require 'zabbixapi'
require 'json'

#require 'webmock/rspec'
#include WebMock::API

# settings
api_url = 'http://zabbix.local/api_jsonrpc.php'
api_login = 'Admin'
api_password = 'zabbix'


zbx = Zabbix::ZabbixApi.new(api_url, api_login, api_password)
#zbx.debug = true

# 01. Create group
describe Zabbix::ZabbixApi, "create_group" do
  it "Create some group" do
    result = zbx.add_group('some_group')
  end
end

# 02. Create host
host_options = { 
  "ip"     => '127.0.0.1',
  "dns"    => 'my.example.com',
  "host"   => 'my.example.com',
  "useip"  => 1,
  "groups" => ['some_group']
}
describe Zabbix::ZabbixApi, "create_host" do
  it "Create host" do
    result = zbx.add_host(host_options)
  end
end

# 03. Get host
describe Zabbix::ZabbixApi, "get_host" do
  it "Get host by name" do
    result = zbx.get_host_id('my.example.com')
  end
end

# 04. Delete group
describe Zabbix::ZabbixApi, "delete_group" do
  it "Delete some group" do
    result = zbx.delete_group('some_group')
  end
end
