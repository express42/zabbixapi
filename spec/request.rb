require 'zabbixapi'
require 'json'
require 'servers/server18'

# settings
api_url = 'http://somehost'
api_login = ''
api_password = ''


zbx = Zabbix::ZabbixApi.new(api_url, api_login, api_password)
#zbx.debug = true

describe Zabbix::ZabbixApi do

  before :each do
    # stub auth tocken
    Zabbix::ZabbixApi.any_instance.stub(:auth).and_return "a9a1f569d10d6339f23c4d122a7f5c46" 
    # stub resquest
    @request = mock
    Net::HTTP.any_instance.stub(:request).and_return @request
    @request.stub(:code).and_return "200"
  end

  # 01. Create group
  it "Create some group" do
    @request.stub(:body).and_return Server18.hostgroup_create
    result = zbx.add_group('some_group')
    result.should equal(107819)
  end

  # 02. Get group_id
  it "Get group_id" do
    @request.stub(:body).and_return Server18.hostgroup_get
    result = zbx.get_group_id('some_group')
    result.should equal(100100000000002)
  end

  # 03. Get unknown group_id
  it "Get unknown group" do
    @request.stub(:body).and_return Server18.hostgroup_get_error
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
    @request.stub(:body).and_return Server18.host_create
    result = zbx.add_host(host_options)
    result.should equal(107819)
  end

  # 05. Get host
  it "Get host by name" do
    @request.stub(:body).and_return Server18.host_get
    result = zbx.get_host_id('my.example.com')
    result.should equal(100100000010017)
  end

  # 06. Get unknown host
  it "Get unknown host by name" do
    @request.stub(:body).and_return Server18.host_get_error
    result = zbx.get_host_id('___my.example.com')
    result.should be_nil
  end

  # 07. Delete host
  it "Delete host" do
    @request.stub(:body).and_return Server18.host_delete
    result = zbx.delete_host('my.example.com')
    result.should be_kind_of(Integer)
  end

  # 08. Delete unknown host
  it "Delete unknown host" do
    @request.stub(:body).and_return Server18.host_delete_error
    result = zbx.delete_host('__my.example.com')
    result.should be_nil
  end

  # 09. Delete group
  it "Delete some group" do
    @request.stub(:body).and_return Server18.hostgroup_delete
    result = zbx.delete_group('some_group')
    result.should be_kind_of(Integer)
  end

  # 10. Delete unknown group
  it "Delete unknown group" do
    @request.stub(:body).and_return Server18.hostgroup_delete_error
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
    @request.stub(:body).and_return Server18.mediatype_create
    result = zbx.add_mediatype(mediatype_options)
    result.should equal(100100000214797)
  end

  # 12. Mediatype unknown delete
  it "Delete unknown mediatype" do
    @request.stub(:body).and_return Server18.mediatype_delete_error
    result = zbx.delete_mediatype('__example_mediatype')
    result.should be_nil
  end

  # 13. Mediatype delete
  it "Delete mediatype" do
    @request.stub(:body).and_return Server18.mediatype_delete    
    result = zbx.delete_mediatype('example_mediatype')
    result.should be_kind_of(Integer)
  end

end
