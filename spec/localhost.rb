require 'zabbixapi'
require 'json'

# settings
api_url = 'http://localhost/zabbix/api_jsonrpc.php'
api_login = 'Admin'
api_password = 'zabbix'


zbx = Zabbix::ZabbixApi.new(api_url, api_login, api_password)
#zbx.debug = true

describe Zabbix::ZabbixApi, "test_api" do

  # 01. Create group
  it "Create some group" do
    result = zbx.add_group('some_group')
    result.should be_kind_of(Integer)
  end

  # 02. Get group_id
  it "Get group_id" do
    result = zbx.get_group_id('some_group')
    result.should be_kind_of(Integer)
  end

  # 03. Get unknown group_id
  it "Get unknown group" do
    result = zbx.get_group_id('___some_group')
    result.should be_nil
  end

  # 04. Create host
  host_options = { 
    "ip"     => '127.0.0.1',
    "dns"    => 'my.example.com',
    "host"   => 'my.example.com',
    "useip"  => 1,
    "groups" => [1]
  }
  it "Create host" do
    result = zbx.add_host(host_options)
    result.should be_kind_of(Integer)
  end

  # 05. Get host
  it "Get host by name" do
    result = zbx.get_host_id('my.example.com')
    result.should be_kind_of(Integer)
  end

  # 06. Get unknown host
  it "Get unknown host by name" do
    result = zbx.get_host_id('___my.example.com')
    result.should be_nil
  end

  # 07. Delete host
  it "Delete host" do
    result = zbx.delete_host('my.example.com')
    result.should be_kind_of(Integer)
  end

  # 08. Delete unknown host
  it "Delete unknown host" do
    result = zbx.delete_host('__my.example.com')
    result.should be_nil
  end

  # 09. Delete group
  it "Delete some group" do
    result = zbx.delete_group('some_group')
    result.should be_kind_of(Integer)
  end

  # 10. Delete unknown group
  it "Delete unknown group" do
    result = zbx.delete_group('___some_group')
    result.should be_nil
  end

  # 11. Mediatype create
  mediatype_options = { 
    'type' => '0', #email
    'description' => 'example_mediatype',
    'smtp_server' => 'test.company.com',
    'smtp_helo'   => 'test.company.com',
    'smtp_email'  => 'test@test.company.com',
  }
  it "Create mediatype" do
    result = zbx.add_mediatype(mediatype_options)
    result.should be_kind_of(Integer)
  end
  # 12. Mediatype unknown delete
  it "Delete unknown mediatype" do
    result = zbx.delete_mediatype('__example_mediatype')
    result.should be_nil
  end

  # 13. Mediatype delete
  it "Delete mediatype" do
    result = zbx.delete_mediatype('example_mediatype')
    result.should be_kind_of(Integer)
  end

end

describe Zabbix::ZabbixApi, "test_examples" do
  it "Test all examples" do
    system("examples/populate_new_zabbix.sh development")
  end
end
