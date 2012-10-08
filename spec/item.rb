require 'zabbixapi'
require 'json'

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
    result = zbx.delete_group(zbx.get_group_id'some_group')
  end
end

# 05. Delete host
describe Zabbix::ZabbixApi, "delete_host" do
  it "Delete host" do
    result = zbx.delete_host('my.example.com')
  end
end

# 06. Mediatype create
mediatype_options = { 
  'type' => '0',
  'description' => 'example_mediatype',
  'smtp_server' => 'test.company.com',
  'smtp_helo'   => 'test.company.com',
  'smtp_email'  => 'test@test.company.com',
}
describe Zabbix::ZabbixApi, "create_mediatype" do
  it "Create mediatype" do
    result = zbx.add_mediatype(mediatype_options)
  end
end

# 07. Mediatype delete
describe Zabbix::ZabbixApi, "create_mediatype" do
  it "Delete mediatype" do
    result = zbx.delete_mediatype('example_mediatype')
  end
end
