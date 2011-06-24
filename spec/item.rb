require 'zabbixapi'
require 'json'

require 'webmock/rspec'
include WebMock::API

# settings
api_url = 'http://zabbix.local/api_jsonrpc.php'
api_login = 'admin'
api_password = 'zabbix'

# 01. Add item
auth_response = '{"jsonrpc":"2.0","result":"a82039d56baba1f92311aa917af9939b","id":83254}'
add_item_response = '{"jsonrpc":"2.0","result":{"itemids":["19541"]},"id":80163}'
item_options = {
  'description' => "Description",
  'key_' => "key[,avg1]",
  'hostid' => '10160',
  'applications' => [ 393 ],
  'history' => 7,
  'trends' => 30, 
  'delay' => 60, 
  'value_type' => 0
}

stub_request(:post, api_url).with(:body => /"method":"user\.authenticate"/).to_return(:body => auth_response)
stub_request(:post, api_url).with(:body => /"method":"item\.create"/).to_return(:body => add_item_response)

describe Zabbix::ZabbixApi, "add_item" do
  it "Create item" do
    zbx = Zabbix::ZabbixApi.new(api_url, api_login, api_password)
    result = zbx.add_item(item_options)
    result.should eq("19541")
  end
end

# 02. Delete item
auth_response = '{"jsonrpc":"2.0","result":"a82039d56baba1f92311aa917af9939b","id":83254}'
delete_item_response = ''
item_options = {
  'description' => "Description",
  'key_' => "key[,avg1]",
  'hostid' => '10160',
  'applications' => [ 393 ],
  'history' => 7,
  'trends' => 30, 
  'delay' => 60, 
  'value_type' => 0
}

stub_request(:post, api_url).with(:body => /"method":"user\.authenticate"/).to_return(:body => auth_response)
stub_request(:post, api_url).with(:body => /"method":"item\.create"/).to_return(:body => add_item_response)

describe Zabbix::ZabbixApi, "add_item" do
  it "Create item" do
    zbx = Zabbix::ZabbixApi.new(api_url, api_login, api_password)
    result = zbx.add_item(item_options)
    result.should eq("19541")
  end
end
