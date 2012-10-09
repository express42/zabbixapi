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
    result.should be_kind_of(Integer)
  end
end

# 02. Get group_id
describe Zabbix::ZabbixApi, "get_group_id" do
  it "Get group_id" do
    result = zbx.get_group_id('some_group')
    result.should be_kind_of(Integer)
  end
end

# 03. Get unknown group_id
describe Zabbix::ZabbixApi, "get_group_id" do
  it "Get unknown group" do
    result = zbx.get_group_id('___some_group')
    result.should be_nil
  end
end

# 04. Create host
host_options = { 
  "ip"     => '127.0.0.1',
  "dns"    => 'my.example.com',
  "host"   => 'my.example.com',
  "useip"  => 1,
  "groups" => [1]
}
describe Zabbix::ZabbixApi, "create_host" do
  it "Create host" do
    result = zbx.add_host(host_options)
    result.should be_kind_of(Integer)
  end
end

# 05. Get host
describe Zabbix::ZabbixApi, "get_host" do
  it "Get host by name" do
    result = zbx.get_host_id('my.example.com')
    result.should be_kind_of(Integer)
  end
end

# 06. Get unknown host
describe Zabbix::ZabbixApi, "get_host" do
  it "Get unknown host by name" do
    result = zbx.get_host_id('___my.example.com')
    result.should be_nil
  end
end

# 07. Delete host
describe Zabbix::ZabbixApi, "delete_host" do
  it "Delete host" do
    result = zbx.delete_host('my.example.com')
    result.should be_kind_of(Integer)
  end
end

# 08. Delete unknown host
describe Zabbix::ZabbixApi, "delete_unknown_host" do
  it "Delete unknown host" do
    result = zbx.delete_host('__my.example.com')
    result.should be_nil
  end
end

# 09. Delete group
describe Zabbix::ZabbixApi, "delete_group" do
  it "Delete some group" do
    result = zbx.delete_group('some_group')
    result.should be_kind_of(Integer)
  end
end

# 10. Delete unknown group
describe Zabbix::ZabbixApi, "delete_unknown_group" do
  it "Delete unknown group" do
    result = zbx.delete_group('___some_group')
    result.should be_nil
  end
end

# 11. Mediatype create
mediatype_options = { 
  'type' => '0', #email
  'description' => 'example_mediatype',
  'smtp_server' => 'test.company.com',
  'smtp_helo'   => 'test.company.com',
  'smtp_email'  => 'test@test.company.com',
}
describe Zabbix::ZabbixApi, "create_mediatype" do
  it "Create mediatype" do
    result = zbx.add_mediatype(mediatype_options)
    result.should be_kind_of(Integer)
  end
end

# 12. Mediatype unknown delete
describe Zabbix::ZabbixApi, "delete_unknown_mediatype" do
  it "Delete unknown mediatype" do
    result = zbx.delete_mediatype('__example_mediatype')
    result.should be_nil
  end
end

# 13. Mediatype delete
describe Zabbix::ZabbixApi, "delete_mediatype" do
  it "Delete mediatype" do
    result = zbx.delete_mediatype('example_mediatype')
    result.should be_kind_of(Integer)
  end
end
